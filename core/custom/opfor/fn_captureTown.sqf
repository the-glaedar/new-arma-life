#include "..\..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_captureTown.sqf

  Description:
  Allows OPFOR to capture one of the towns, progressBar and all.
*/
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function captureTown called.";
private["_town","_flag","_level","_cpRate"];

_town = _this select 3 select 0;
_flag = _this select 3 select 1;

_level = (FETCH_CONST(life_opforlevel));
_cpRate = 0.0025;

// Checks to see if already captured, capturing and if minimum level is satisfied
if (_flag getVariable "captured" isEqualTo true) exitWith {diag_log "::New Arma:: Failed: Already captured";systemChat "Town already captured";};
if (_flag getVariable "inUse" isEqualTo true) exitWith {diag_log "::New Arma:: Failed: Flag inUse";systemChat "Someone else is using this";};
if (_level < 3) exitWith {diag_log "::New Arma:: Failed: Not high enough level";systemChat "You must be a SGT or higher to do this";};

systemChat format ["Capturing %1 Outpost",_town];
diag_log format ["::New Arma:: Player started capturing flag at %1",_town];

[] spawn {
  if (player distance riviere_flag > 15) exitWith { life_action_inUse = false;_flag setVariable ["inUse",false,true];};
  if (!alive player || life_istazed || life_isknocked) exitWith {life_action_inUse = false;_flag setVariable ["inUse",false,true];};
  if (player getVariable ["restrained",false]) exitWith {life_action_inUse = false;_flag setVariable ["inUse",false,true];};
  if (life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"]; life_action_inUse = false;_flag setVariable ["inUse",false,true];};
};

// Progress Bar
disableSerialization;
private _title = localize "STR_ONOTF_Capturing";
"progressBar" cutRsc ["life_progress","PLAIN"];
private _ui = uiNamespace getVariable "life_progress";
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format ["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
private _cP = 0.01;

for "_i" from 0 to 1 step 0 do {
    sleep 0.26;
    if (isNull _ui) then {
        "progressBar" cutRsc ["life_progress","PLAIN"];
        _ui = uiNamespace getVariable "life_progress";
        _progressBar = _ui displayCtrl 38201;
        _titleText = _ui displayCtrl 38202;
    };
    _cP = _cP + _cpRate;
    _progressBar progressSetPosition _cP;
    _titleText ctrlSetText format ["%3 (%1%2)...",round(_cP * 100),"%",_title];
    _flag setVariable ["inUse",true,true];

    // Checks if done, if so, resets the progress bar and sets variable on console
    if (_cP >= 1 || !alive player) exitWith {life_action_inUse = false;_flag setVariable ["inUse",false,true];_flag setVariable ["captured",true,true];};
    if (life_istazed) exitWith {life_action_inUse = false;_flag setVariable ["inUse",false,true];_flag setVariable ["captured",false,true];}; //Tazed
    if (life_isknocked) exitWith {life_action_inUse = false;_flag setVariable ["inUse",false,true];_flag setVariable ["captured",false,true];}; //Knocked
    if (life_interrupted) exitWith {life_action_inUse = false;_flag setVariable ["inUse",false,true];_flag setVariable ["captured",false,true];};
};

diag_log "::New Arma:: Town Captured";
_flag setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";

if (_town isEqualTo "Larche") then {
  _flag setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
  larche_flag_2 setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
  larche_flag_3 setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
} else if (_town isEqualTo "Riviere") then {
  _flag setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
  riviere_flag_2 setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
  riviere_flag_3 setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
  riviere_flag_4 setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
  riviere_flag_5 setFlagTexture "A3\Data_F\Flags\Flag_CSAT_co.paa";
};

private _participant = nearestObjects [(getMarkerPos larche_radius), ["Man"], 150];
{
  if (playerSide isEqualTo east) then {
    life_opforRep_temp = life_opforRep_temp + 10;
  };
} forEach _participant;


//Kill the UI display and check for various states
"progressBar" cutText ["","PLAIN"];


// Send out signal to opfor, etcetera.
