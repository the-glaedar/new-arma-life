/*
  File: fn_lockDoor.sqf
  Author: Glaedar

  Description:
  Locks or unlocks the nearest door.
*/
private ["_failOne","_door","_playerSide"];
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function lockDoor called.";

_failOne = {
  diag_log "::New Arma:: Failed: No door found";
};

_door = _this select 3 select 0;
_playerSide = _this select 3 select 1;

if (_door isEqualTo nil) exitWith {_failOne;};
/*
** Federal Reserve Security Door
*/
if (_playerSide isEqualTo west) then {
  // Them virtual doors
  if (_door isEqualTo bank_fed_console_4) then {

    hideObject bank_vgate_fed_2;
    bank_invis_wall_3 enableSimulation false;
    bank_invis_wall_4 enableSimulation false;
  };

  if ((_door getVariable "BIS_disabled_Door_1") isEqualTo 0 && (_door getVariable "hacked") isEqualTo false) then {
    diag_log "::New Arma:: Door is unlocked, closing and locking door";

    // Unlock and move door
    _door animate ["Door_1_Move", 0];
    _door setVariable ["BIS_disabled_Door_1", 1, true];
  } else {
    diag_log "::New Arma:: Door is locked, opening and unlocking door";
    _door animate ["Door_1_Move", 1];
    _door setVariable ["BIS_disabled_Door_1", 0, true];
  };
} else {
  if (_door getVariable "hacked") then {
    // Insert repair script here.
  };
  if (_playerSide isEqualTo west) then {
    systemchat "Only officers of the law may do this";
    diag_log "::New Arma:: Failed: Player not a member of the west faction";
  }

};
