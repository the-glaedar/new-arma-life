#include "..\..\..\script_macros.hpp"
/*
  File: fn_robBank.sqf
  Author: Glaedar

  Description:
  Robs the bank and gives award based on ocrime level. Increases ocrime level
*/
private[];
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function robBank called.";

_failOne = {
  diag_log "::New Arma:: Failed: What bank??";
};

_failTwo = {
  diag_log "::New Arma:: Failed: Inventory Full";
};

_level = FETCH_CONST(life_ocrime);

life_safeObj = fed_safe;

_rewardType = goldbar;
_robber = _this select 1;
_bank = _this select 3 select 0;
_bankQuantity = _this select 3 select 1;
_robbed = _this select 3 select 2;

// Master - if not already robbed, catch any exploits.
  // if fed bank
  if (_bank isEqualTo "fed") then {
    // Determine how many gold bars there are in the bank, scales off of level
    _rewardAmount = ((random [5, 12, 20]) * (round (_level*0.2)));

    // Opens safe dialog
    /*
    if (dialog) exitWith {}; //A dialog is already open.
    life_safeObj = param [0,objNull,[objNull]];
    if (isNull life_safeObj) exitWith {diag_log"error with safe";};
    if !(playerSide isEqualTo civilian) exitWith {};
    if ((life_safeObj getVariable ["safe",-1]) < 1) exitWith {hint localize "STR_Civ_VaultEmpty";};
    if (life_safeObj getVariable ["inUse",false]) exitWith {hint localize "STR_Civ_VaultInUse"};
    if (west countSide playableUnits < (LIFE_SETTINGS(getNumber,"minimum_cops"))) exitWith {
        hint format [localize "STR_Civ_NotEnoughCops",(LIFE_SETTINGS(getNumber,"minimum_cops"))];
    };
    if (!createDialog "Federal_Safe") exitWith {localize "STR_MISC_DialogError"};

    disableSerialization;
    ctrlSetText[3501,(localize "STR_Civ_SafeInv")];
    [life_safeObj] call life_fnc_safeInventory;
    life_safeObj setVariable ["inUse",true,true];

    [life_safeObj] spawn {
        waitUntil {isNull (findDisplay 3500)};
        (_this select 0) setVariable ["inUse",false,true];
    };
    */

    diag_log format ["::New Arma:: Client stole %1 gold bars from the federal reserve",_reward];
  }
}
