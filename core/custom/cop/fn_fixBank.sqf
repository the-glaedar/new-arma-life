#include "..\..\..\script_macros.hpp"
/*
  File: fn_fixBank.sqf
  Author: Glaedar

  Description:
  Essentially closes all the gates, refills the safe, etcetera.
*/
private[];
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function fixBank called.";

_failOne = {
  diag_log "::New Arma:: Failed: Doors already sealed";
  systemChat "Doors are already sealed";
};

_console = _this select 3;
_cpRate = 0.0025;

/*
** Federal Reserve
*/
if (_console isEqualTo bank_fed_console_1) then {
  diag_log "::New Arma:: Sealing all gates at Malden Federal Reserve";
  systemchat "Reactivating security system, please stay within 15m of security console";

  // Progress Bar
  disableSerialization;
  private _title = localize "STR_NOTF_Fixing";
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
      bank_fed_console_1 setVariable ["inUse",true,true];

      // Checks if done, if so, resets the progress bar and sets variable on console
      if (_cP >= 1 || !alive player) exitWith {};
      if (life_istazed) exitWith {}; //Tazed
      if (life_isknocked) exitWith {}; //Knocked
      if (life_interrupted) exitWith {};
  };

  //Kill the UI display and check for various states
  "progressBar" cutText ["","PLAIN"];

  if (player distance bank_fed_console_1 > 15) exitWith { life_action_inUse = false;bank_fed_console_1 setVariable ["inUse",false,true];};
  if (!alive player || life_istazed || life_isknocked) exitWith {life_action_inUse = false;bank_fed_console_1 setVariable ["inUse",false,true];};
  if (player getVariable ["restrained",false]) exitWith {life_action_inUse = false;bank_fed_console_1 setVariable ["inUse",false,true];};
  if (life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"]; life_action_inUse = false;bank_fed_console_1 setVariable ["inUse",false,true];};

  // Reset console statuses
  bank_fed_console_1 setVariable ["robbed", false, true];
  bank_fed_console_2 setVariable ["robbed", false, true];

  // Close and lock gates
  bank_gate_fed_1 animate ["Door_1_Move", 0];
  bank_gate_fed_2 animate ["Door_1_Move", 0];
  bank_gate_fed_1 setVariable ["BIS_disabled_Door_1",1];
  bank_gate_fed_2 setVariable ["BIS_disabled_Door_1",1];

  // Invis Walls
  bank_invis_wall_3 enableSimulation true;
  bank_invis_wall_4 enableSimulation true;
  bank_vgate_fed_2 hideObject false;

  // Refill safe
  _randValue = random [5,10,15];
  fed_bank setVariable ["bank",_randValue,true];
}
