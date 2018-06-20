#include "..\..\..\script_macros.hpp"
/*
  File: fn_hackBankDoor.sqf
  Author: Glaedar

  Description:
  Main script for robbing bank.
*/
private ["_level", "_failOne", "_failTwo","_failThree", "_door", "_robber", "_notfBool"];
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function hackBankDoor called.";

_failOne = {
  diag_log "::New Arma:: Failed: Door already hacked.";
  systemChat "The door is already unlocked";
};
_failTwo = {
  diag_log "::New Arma:: Failed: Player didn't agree to antecedent conditions";
  systemChat "You must agree with the antecedent conditions to rob the bank";
};
_failThree = {
  diag_log "::New Arma:: Failed: Police must repair the vault before fixing the door";
  systemChat "Vault must be repaired before the door";
};

// Which door and who is doing it?
_door = _this select 3;
_cpRate = 0.0025;

if ((_door getVariable "BIS_disabled_Door_1") isEqualTo 0) exitWith {_failOne;};

/*
** Federal Reserve
*/
// Federal Reserve - Door One
if (_door isEqualTo bank_gate_fed_1) then {
  // Alerts of the antecedent conditions
  diag_log "::New Arma:: Federal Reserve Door 1 being hacked";
  _notfBool = ["Doing this is considered an act of terrorism, and will lead to an extended jail sentence, proceed?","Bank Robbery",true,true] call BIS_fnc_guiMessage;
  if (_notfBool isEqualTo false) exitWith {_failTwo};



  // Fetches all of the players within 50m of the hacked door and adds a charge of terrorism to them
  _playerArray = nearestObjects [bank_fed_console_1, ["Civilian"], 50];
  {
    [getPlayerUID player,player getVariable ["realname",name player],"667"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
    diag_log format ["::New Arma:: 1 Charge of Terrorism added to %1",(player getVariable ["realname",name player])];
    systemChat "One charge of terrorism has been added to your police record";
  } forEach _playerArray;

  // Progress Bar
  disableSerialization;
  private _title = localize "STR_NOTF_Hacking";
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

  if (player distance bank_fed_console_1 > 15) exitWith { life_action_inUse = false;bank_fed_console_1 setVariable ["inCapture",false,true];};
  if (!alive player || life_istazed || life_isknocked) exitWith {life_action_inUse = false;bank_fed_console_1 setVariable ["inCapture",false,true];};
  if (player getVariable ["restrained",false]) exitWith {life_action_inUse = false;bank_fed_console_1 setVariable ["inCapture",false,true];};
  if (life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"]; life_action_inUse = false;bank_fed_console_1 setVariable ["inCapture",false,true];};

  diag_log "::New Arma:: Federal Reserve Door 1 opened";

  // Opens and unlocks the door
  //_door setVariable ["BIS_disabled_Door_1", 0, true];
  _door animate ["Door_1_Move", 1];
};

// Federal Reserve - Door Two
if (_door isEqualTo bank_gate_fed_2) then {
  diag_log "::New Arma:: Federal Reserve Door 2 [Bank Door] being hacked";

  _playerArray = nearestObjects [bank_fed_console_3, ["Civilian"], 50];
  {
    [getPlayerUID player,player getVariable ["realname",name player],"23"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
    diag_log format ["::New Arma:: 1 Charge of Bank Robbery added to %1",(player getVariable ["realname",name player])];
    systemChat "One charge of bank robbery has been added to your police record";

  } forEach _playerArray;

  disableSerialization;
  private _title = localize "STR_NOTF_Hacking";
  "progressBar" cutRsc ["life_progress","PLAIN"];
  private _ui = uiNamespace getVariable "life_progress";
  private _progressBar = _ui displayCtrl 38201;
  private _titleText = _ui displayCtrl 38202;
  _titleText ctrlSetText format ["%2 (1%1)...","%",_title];
  _progressBar progressSetPosition 0.01;
  private _cP = 0.01;

  for "_i" from 0 to 1 step 0 do {
      sleep 0.36;
      if (isNull _ui) then {
          "progressBar" cutRsc ["life_progress","PLAIN"];
          _ui = uiNamespace getVariable "life_progress";
          _progressBar = _ui displayCtrl 38201;
          _titleText = _ui displayCtrl 38202;
      };
      _cP = _cP + _cpRate;
      _progressBar progressSetPosition _cP;
      _titleText ctrlSetText format ["%3 (%1%2)...",round(_cP * 100),"%",_title];
      bank_fed_console_2 setVariable ["inUse",true,true];

      // Checks if done, if so, resets the progress bar and sets variable on console
      if (_cP >= 1 || !alive player) exitWith {};
      if (life_istazed) exitWith {}; //Tazed
      if (life_isknocked) exitWith {}; //Knocked
      if (life_interrupted) exitWith {};
  };

  //Kill the UI display and check for various states
  "progressBar" cutText ["","PLAIN"];

  if (!alive player || life_istazed || life_isknocked) exitWith {life_action_inUse = false;bank_fed_console_3 setVariable ["inCapture",false,true];};
  if (player getVariable ["restrained",false]) exitWith {life_action_inUse = false;bank_fed_console_3 setVariable ["inCapture",false,true];};
  if (life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"]; life_action_inUse = false;bank_fed_console_3 setVariable ["inCapture",false,true];};
  _door setVariable ["BIS_disabled_Door_1", 0, true];
  _door animate ["Door_1_Move", 1];
  bank_fed_console_3 setVariable ["robbed", true, true];

  if (life_ocrime_temp isEqualTo 20) then {
    hint "Level progress was not earned as you are currently at the maximum organised crime level (20)";
  } else {
    life_ocrime_temp = life_ocrime_temp + 1;
    [13] call SOCK_fnc_updatePartial;
  };
};


/*
** Malden Prison
*/
// Malden Prison - Main Door
if (_door isEqualTo prison_gate_1) then {
  diag_log "::New Arma:: Prison Gate Door 1 being hacked";
  _notfBool = ["Doing this is condiered a serious act of terroism, and will lead to an extended jail sentence for the perpetrators and detainees, proceed?","Jail Break-Out",true,true] call BIS_fnc_guiMessage;

  // Adds charges of terroism to everyone within the area
    _playerArray = nearestObjects [bank_fed_console_3, ["Civilian"], 50];
    {
      [getPlayerUID player,player getVariable ["realname",name player],"23"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
      diag_log format ["::New Arma:: 1 Charge of Terrorism added to %1",(player getVariable ["realname",name player])];
      systemChat "One charge of terrorism has been added to your police record";
    } forEach _playerArray;


    disableSerialization;
    private _title = localize "STR_NOTF_Hacking";
    "progressBar" cutRsc ["life_progress","PLAIN"];
    private _ui = uiNamespace getVariable "life_progress";
    private _progressBar = _ui displayCtrl 38201;
    private _titleText = _ui displayCtrl 38202;
    _titleText ctrlSetText format ["%2 (1%1)...","%",_title];
    _progressBar progressSetPosition 0.01;
    private _cP = 0.01;

    for "_i" from 0 to 1 step 0 do {
        sleep 0.36;
        if (isNull _ui) then {
            "progressBar" cutRsc ["life_progress","PLAIN"];
            _ui = uiNamespace getVariable "life_progress";
            _progressBar = _ui displayCtrl 38201;
            _titleText = _ui displayCtrl 38202;
        };
        _cP = _cP + _cpRate;
        _progressBar progressSetPosition _cP;
        _titleText ctrlSetText format ["%3 (%1%2)...",round(_cP * 100),"%",_title];
        prison_console_1 setVariable ["inUse",true,true];

        // Checks if done, if so, resets the progress bar and sets variable on console
        if (_cP >= 1 || !alive player) exitWith {};
        if (life_istazed) exitWith {}; //Tazed
        if (life_isknocked) exitWith {}; //Knocked
        if (life_interrupted) exitWith {};
    };

    //Kill the UI display and check for various states
    "progressBar" cutText ["","PLAIN"];
    if (!alive player || life_istazed || life_isknocked) exitWith {life_action_inUse = false;prison_console_1 setVariable ["inCapture",false,true];};
    if (player getVariable ["restrained",false]) exitWith {life_action_inUse = false;prison_console_1 setVariable ["inCapture",false,true];};
    if (life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"]; life_action_inUse = false;prison_console_1 setVariable ["inCapture",false,true];};

    hideObject prison_gate_1;
    hideObject prison_gate_2;
    prison_gate_1 enableSimulation false;
    prison_gate_2 enableSimulation false;

    prison_security_door_1 animate ["Door_1_Move", 1];
    prison_security_door_2 animate ["Door_1_Move", 1];

    // LEVEL UP!
    if (life_ocrime_temp isEqualTo 20) then {
      hint "Level progress was not earned as you are currently at the maximum organised crime level (20)";
    } else {
      life_ocrime_temp = life_ocrime_temp + 1;
      hint "Level Up!";
      [13] call SOCK_fnc_updatePartial;
    };
  };
