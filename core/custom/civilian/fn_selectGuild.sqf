#include "..\..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_selectGuild.sqf

  Description:
  Join a guild, which one though?
*/
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function selectGuild called.";
private["_guild","_failOne","_failTwo","_requiredItem"];
_guild = (_this select 0) getVariable "guild";
_failOne = {
  if (_guild isEqualTo "mafia") then {
    diag_log "::New Arma:: Failed: Player didn't have enough money/cocaine";
    systemChat "Joining the mafia costs $300,000 and 5 processed cocaine";
    hint "Joining the mafia costs $300,000 and 5 processed cocaine";
  };
  if (_guild isEqualTo "trade") then {
    diag_log "::New Arma:: Failed: Player didn't have enough money or a high enough processing level";
    systemChat "Joining the trade guild costs $95,000 and you must be level 150 in processing";
    hint "Joining the trade guild costs $95,000 and you must be level 150 in processing";
  };
};

_failTwo = {
  if (_guild isEqualTo "mafia") then {
    diag_log "::New Arma:: Failed: Player is already a part of the mafia";
    systemChat "You are already part of the mafia";
  };
  if (_guild isEqualTo "trade") then {
    diag_log "::New Arma:: Failed: Player is already a part of the trade guild";
    systemChat "You are already part of the trade guild";
  };
  if (_guild isEqualTo "thieves") then {
    diag_log "::New Arma:: Failed: Player is already a part of the thieves guild";
    systemChat "You are already part of the thieves guild";
  }
};

// If Mafia
if (_guild isEqualTo "mafia") then {
  // Check for antecedent conditions
  if (life_cash < 300000 || missionNamespace getVariable "life_inv_cocaine_processed" < 5) exitWith {_failOne;};
  if (life_guild_temp isEqualTo 2) exitWith {_failTwo;};

  // Change stuff
  life_guild_temp = 2;
  [false, "cocaine_processed", 5] call life_fnc_handleInv;
  CASH = CASH - 300000;
};

// If Trade Guild
if (_guild isEqualTo "trade") then {
  // Check antecedent conditions
  if (CASH < 95000 || life_processing_temp < 150) exitWith {_failOne;};
  if (life_guild_temp isEqualTo 2) exitWith {_failTwo;};

  // Change stuff
  CASH = CASH - 350000;
  diag_log "::New Arma:: SQL table updated";
  life_guild_temp = 1;
};

if (_guild isEqualTo "thieves") then {
  // Check antecedent conditions
  if (CASH < 100000) exitWith {_failOne;};
  if (life_guild_temp isEqualTo 3) exitWith {_failTwo;};

  // Change stuff
  life_guild_temp = 3;
  CASH = CASH - 100000;
};

// Commit changes to databse
[0] call SOCK_fnc_updatePartial;
[0] call life_fnc_updateStats;
