#include "..\..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_opforPickup.sqf

  Description:
  This script is called on each person's member of OPFOR's client by fn_pickupStart when
  an opfor higher up starts a delivery mission.
*/
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function opforPickup called.";
private ["_startPoint"];

_startPoint = (_this select 0);
_endPoint = (_this select 1);

player setVariable ["pickupInProg",true,true];

life_opfor_pickup_in_progress = true;

life_opforRep_temp = life_opforRep_temp + 1;

life_opfor_task_master = player createSimpleTask ["opfortaskmaster"];
life_opfor_task_master setSimpleTaskDescription ["Current Mission","Capture the drop",""];
life_opfor_task_master setTaskState "Assigned";

life_opfor_task_pickup = player createSimpleTask ["opfortaskpickup"];
life_opfor_task_pickup setSimpleTaskDescription ["Pickup Shipment","Pickup the weaponry shipment from the location on your map"];
life_opfor_task_pickup setTaskState "Assigned";
life_opfor_task_pickup setSimpleTaskDestination (getMarkerPos _endPoint);
player setCurrentTask life_opfor_task_pickup;

["DeliveryAssigned", [format [localize "STR_NOTF_StartDrop"]]] call BIS_fnc_showNotification;

waitUntil {(player distance _endpoint) < 100;};

life_opfor_task_pickup setTaskState "Succeeded";
life_opfor_task_master setTaskState "Succeeded";

private _reward = 5000 * (0.5 ^ (FETCH_CONST(life_opforlevel)));
BANK = BANK + _reward;

life_opforRep_temp = life_opforRep_temp + 5;
systemChat format ["Rep level increased by 5 points, your current rep level is %1",life_opforRep_temp];
systemChat format ["$%1.00 was deposited into your account for securing the shipment. Thank you for your service.",_reward];
[18] call SOCK_fnc_updatePartial;
[1] call SOCK_fnc_updatePartial;

{
  if (playerSide isEqualTo east) then {

  }
  remoteExec life_fnc_pickupFinish;
} forEach

life_opfor_pickup_in_progress = false;

[] spawn {
  waitUntil {!alive player || !life_opfor_pickup_in_progress} exitWith {
      life_opfor_task_pickup setTaskState "Failed";
      life_opfor_task_master setTaskState "Failed";
      life_opforRep_temp = life_opforRep_temp + 2;
      [18] call SOCK_fnc_updatePartial;
      life_opfor_pickup_in_progress = false;
    };
};
