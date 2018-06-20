#include "..\..\..\script_macros.hpp"
/*
  Name: requestReceivedStats.sqf
  Author: Tonic & Glaedar

  Description:
  Called from fn_queryRequest in @life_server.
*/
// Logs where it's at and which executed faster
if (life_session_completed) then {
  diag_log "::New Arma:: Data retrieved from stats table";
} else {
  diag_log "::New Arma:: Information received from `stats` table";
};

//Error handling
if (isNil "_this") exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if (_this isEqualType "") exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if (count _this isEqualTo 0) exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if ((_this select 0) isEqualTo "Error") exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if (!(getPlayerUID player isEqualTo (_this select 0))) exitWith {[] call SOCK_fnc_dataQuery;};

//Lets make sure some vars are not set before hand.. If they are get rid of them, hopefully the engine purges past variables but meh who cares.
/*
** Commented out for now but I will need to return to this for security

if (!isServer && (!isNil "life_guild" || !isNil "life_ocrime" || !isNil "life_donorlevel")) exitWith {
    [profileName,getPlayerUID player,"VariablesAlreadySet"] remoteExecCall ["SPY_fnc_cookieJar",RSERV];
    [profileName,format ["Variables set before client initialization...\nlife_adminlevel: %1\nlife_coplevel: %2\nlife_donorlevel: %3",life_adminlevel,life_coplevel,life_donorlevel]] remoteExecCall ["SPY_fnc_notifyAdmins",RCLIENT];
    sleep 0.9;
    failMission "SpyGlass";
};
*/

// Parse side-specific information
switch (playerSide) do {
  case west: {
    CONST(life_guild,0);
    CONST(life_ocrime,0);
    CONST(life_gcrime,0);
    CONST(life_vcrime,0);
    CONST(life_taxi,0);
    CONST(life_delivery,0);
    CONST(life_processing,0);
    CONST(life_gathering,0);
    CONST(life_civRep,0);
    CONST(life_indepRep,0);
    CONST(life_copRep,(_this select 11));
    CONST(life_opforRep,0);
  };

  case civilian: {
    CONST(life_guild,(_this select 1));
    CONST(life_ocrime,(_this select 2));
    CONST(life_gcrime,(_this select 3));
    CONST(life_vcrime,(_this select 4));
    CONST(life_taxi,(_this select 5));
    CONST(life_delivery,(_this select 6));
    CONST(life_processing,(_this select 7));
    CONST(life_gathering,(_this select 8));
    CONST(life_civRep,(_this select 9));
    CONST(life_indepRep,0);
    CONST(life_copRep,(0));
    CONST(life_opforRep,0);
  };

  case independent: {
    CONST(life_guild,0);
    CONST(life_ocrime,0);
    CONST(life_gcrime,0);
    CONST(life_vcrime,0);
    CONST(life_taxi,0);
    CONST(life_delivery,0);
    CONST(life_processing,0);
    CONST(life_gathering,0);
    CONST(life_civRep,0);
    CONST(life_indepRep,(_this select 10));
    CONST(life_copRep,0);
    CONST(life_opforRep,0);
  };

  case east: {
    CONST(life_guild,0);
    CONST(life_ocrime,0);
    CONST(life_gcrime,0);
    CONST(life_vcrime,0);
    CONST(life_taxi,0);
    CONST(life_delivery,0);
    CONST(life_processing,0);
    CONST(life_gathering,0);
    CONST(life_civRep,0);
    CONST(life_indepRep,0);
    CONST(life_copRep,0);
    CONST(life_opforRep,(_this select 12));
  };
};

life_session_completed_2 = true;
