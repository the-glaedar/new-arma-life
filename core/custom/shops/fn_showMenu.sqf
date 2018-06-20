#include "..\..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_showMenu.sqf

  Description:
  Creates a dialog, first checking for antecedent conditions.
*/
diag_log "::New Arma:: fn_showMenu called";

private _menu = _this select 3 select 0;
diag_log format ["%1",_menu];

switch (_menu) do {
  case "nadf": {
    if !(playerSide isEqualTo west) exitWith {};
    if (life_opforLevel < 3) exitWith {}; // Level Check
    // insert check to see if display is open
    createDialog "nadf_int";
  };

  case "gang": {

  };

};
