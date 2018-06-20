#include "..\..\..\script_macros.hpp
/*
  Author: Glaedar & Tonic
  File: fn_joinGroup.sqf

  Description:
  Adds a member of OPFOR to a group. Executed by the ranking officer
*/
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function joinGroup called.";
private ["_player","_group","_mode","_uid","_mode"];
_player = _this select 0;
_group = _this select 1;
_mode = _this select 2;

_uid = getPlayerUID _player;
/*
Call example ["player","group","mode"]
player - player that is being affected
group - group the player is joining.
mode - boolean, true if join, false if kick
*/

switch (_mode) do {
  case true: {
    // If joining
    _members pushBack getPlayerUID _player;
    _group setVariable ["gang_members",_members,true];
  };
  case false: {
    // If leaving
    _members = _members - [_uid];
    group _player setVariable ["gang_members",_members,true];
  };
};

[0,group _player] call SOCK_fnc_updateGroup;
