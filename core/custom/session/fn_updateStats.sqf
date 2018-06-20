#include "..\..\..\script_macros.hpp"
/*
  File: fn_updateStats.sqf
  Author: Glaedar & Bryan (Tonic) Boardwine

  Description:
  Updates player stats and keeps the packet size down. Carbon
  copy of fn_updatePartial.sqf
*/
private ["_mode","_packet","_array","_flag"];
_mode = param [0,0,[0]];
_packet = [getPlayerUID player,playerSide,nil,_mode];
_array = [];
_flag = switch (playerSide) do {case west: {"cop"}; case civilian: {"civ"}; case independent: {"med"}; case east: {"opfor"};};

switch (_mode) do {
  case 0: {
    _packet set[2,life_guild_temp];
  };

  case 1: {
    _packet set[2,life_taxi_temp];
  };

  case 2: {
    _packet set[2,life_delivery_temp];
  };

  case 3: {
    _packet set[2,life_processing_temp];
  };

  case 4: {
    _packet set[2,life_gathering_temp];
  };

  case 5: {
    _packet set[2,life_ocrime_temp];
  };

  case 6: {
    _packet set[2,life_vcrime_temp];
  };

  case 7: {
    _packet set[2,life_gcrime_temp];
  };

  case 8: {
    switch (_flag) do {
      case "civ": {
        _packet set[2,life_civRep_temp];
      };
      case "med": {
        _packet set[2,life_indepRep_temp];
      };
      case "cop": {
        _packet set[2,life_copRep_temp];
      };
      case "opfor": {
        _packet set[2,life_opforRep_temp];
      };
    };
  };
};

if (life_HC_isActive) then {
//  _packet remoteExecCall ["HC_fnc_updateStats",HC_Life];
} else {
  _packet remoteExecCall ["DB_fnc_updateStats",RSERV];
};
