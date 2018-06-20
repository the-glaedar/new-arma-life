#include "..\..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_getGangDPMission.sqf

  Description:
  Complete script for a gang DP mission
*/
private ["_markerArray","_arrayValue","_distanceModifier","_exitLoop","_pickupPoint","_randomPoint","_pickupPointPos","_dropoffPoint","_dropoffPointPos","_vehSpawnPoint","_vehicle","_containerType","_life_dp_task_start_illegal","_life_dp_task_illegal_master","_life_dp_task_pickup_illegal","_life_dp_task_dropoff_illegal","_life_dp_task_final"];
diag_log " ////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						 	  		 	Script created by Glaedar @ newarma.life  	        	   						 	   // ";
diag_log " //	 						Do not use without the express written permission of the author			  		 	     // ";
diag_log " //	   											     admin@newarma.life        	                   									 // ";
diag_log " ////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function getGangDPMission called";

packageLoaded = false;
_copCount = 0;
_exitLoop = false;
_baseDistance = 1500;
_vehicleType = "C_Truck_02_transport_F";
_markerArray = LIFE_SETTINGS(getArray,"delivery_points_illegal");

// Fetches cop count
{
  if ((side _x) isEqualTo west) then {
    _copCount = _copCount + 1;
  };
} forEach allPlayers;

// Gang level is used in this instance

// need to chuck it into here V

if (life_dynamicDP) then {
  if (life_gcrime_temp <= 10) then {
    _distanceModifier = 1;
  };
  if (life_gcrime_temp > 10 && life_gcrime_temp <= 20) then {
    _distanceModifier = 1.25;
  };
  if (life_gcrime_temp > 20 && life_gcrime_temp <= 30) then {
    _distanceModifier = 1.5;
  };
  if (life_gcrime_temp > 30 && life_gcrime_temp <= 40) then {
    _distanceModifier = 1.75;
  };
} else {
  _distanceModifier = 0.1;
};

// Selects a random pickup point
while {_exitLoop isEqualTo false} do {
  _pickupPoint = _markerArray call BIS_fnc_selectRandom;
  _randomPoint = [[[_pickupPoint, 100]], []] call BIS_fnc_randomPos;

  if ((count (nearestObjects [_randomPoint, [], 8]) isEqualTo 0) && !(isOnRoad _randomPoint)) then {
    _pickupPointPos = _randomPoint;
    _exitLoop = true;
    diag_log format ["::New Arma:: Successfully found a clear place to spawn at %1, located at coordinates %2",_pickupPoint, _randomPoint];
  };
};

_exitLoop = false;
// Selects a random dropoff point
if (life_dynamicDP) then {
  while {_exitLoop isEqualTo false} do {
    _dropoffPoint = _markerArray call BIS_fnc_selectRandom;
    _dropoffPointPos = _dropoffPoint;
    if ((_dropoffPointPos distance _pickupPointPos) > (_baseDistance * _distanceModifier)) then {
      _exitLoop = true;
    };
  };
} else {
  _exitLoop = false;
  while {_exitLoop isEqualTo false} do {
    _dropoffPoint = _markerArray call BIS_fnc_selectRandom;
    _dropoffPointPos = getMarkerPos _dropoffPoint;
    _randomPoint = [[[_dropoffPoint, 100]], []] call BIS_fnc_randomPos;

    if (((_dropoffPointPos distance _pickupPointPos) >= _baseDistance) && (count (nearestObjects [_randomPoint, [], 8]) isEqualTo 0) && !(isOnRoad _randomPoint)) then {
      _dropoffPointPos = _randomPoint;
      _exitLoop = true;
    };
  };
};

_missionFailOne = {
  diag_log "::New Arma:: Failed: Delivery already in progress";
  hint "You must finish your current delivery mission before trying to start another one";
  systemchat "You must finish your current delivery mission before trying to start another one";
};

_missionFailTwo = {
  diag_log "::New Arma:: Failed: Vehicles blocking the spawn point";
  hint "There is a vehicle blocking the spawn point, contact an administrator for assistance";
  systemchat "There is a vehicle blocking the spawn point, contact an administrator for assistance";
};

_missionFailThree = {
  diag_log "::New Arma:: Failed: Not enough police officers online";
  hint "There must be at least 8 police officers online to be able to do this";
  systemchat "There must be at least 8 police officers online to be able to do this";
};

if (_copCount < 8) exitWith {_missionFailThree;};
if (life_delivery_in_progress_illegal) exitWith { _missionFailOne;};

if (life_dynamicDPContainers) then {
  switch (life_gcrime_temp) do {
    case 1: {
      _vehicleType = "C_Quadbike_01_F";
      _containerType = "Land_MetalCase_01_small_F";
    };
    case 2: {
      _vehicleType = "C_Quadbike_01_F";
      _containerType = "Land_MetalCase_01_small_F";
    };
    case 3: {
      _vehicleType = "C_Quadbike_01_F";
      _containerType = "Land_MetalCase_01_small_F";
    };
    case 4: {
      _vehicleType = "C_Offroad_01_F";
      _containerType = "Land_CargoBox_V1_F";
    };
    case 5: {
      _vehicleType = "C_Offroad_01_F";
      _containerType = "Land_CargoBox_V1_F";
    };
    case 6: {
      _vehicleType = "C_Offroad_01_F";
      _containerType = "Land_CargoBox_V1_F";
    };
    case 7: {
      _vehicleType = "C_Offroad_01_F";
      _containerType = "Land_CargoBox_V1_F";
    };
    case 8: {
      _vehicleType = "C_Truck_02_transport_F";
      _containerType = "Land_CargoBox_V1_F";
    };
    case 9: {
      _vehicleType = "C_Truck_02_transport_F";
      _containerType = "Land_CargoBox_V1_F";
    };
    case 10: {
      _vehicleType = "C_Truck_02_transport_F";
      _containerType = "Land_CargoBox_V1_F";
    };
  };
} else {
  diag_log "bam";
  _vehicleType = "C_Truck_02_transport_F";
  _containerType = "Land_MetalCase_01_small_F";
};

if ((player distance (getMarkerPos "gang_hideout_1")) < 100) then { _vehSpawnPoint = (getMarkerPos "gang_mission_spawn_1");};
if ((player distance (getMarkerPos "gang_hideout_2")) < 100) then { _vehSpawnPoint = (getMarkerPos "gang_mission_spawn_2");};
if ((player distance (getMarkerPos "gang_hideout_3")) < 100) then { _vehSpawnPoint = (getMarkerPos "gang_mission_spawn_3");};

// Checks for vehicle on spawn point
diag_log "here1";
//if (count (nearestObjects [ _vehSpawnPoint, [], 10]) != 0) exitWith { _missionFailTwo };
diag_log "here2";
diag_log format ["vehType is %1 | vehspawn is %2",_vehicleType,_vehSpawnPoint];
// Spawn vehicle
//_vehicle = createVehicle[_vehicleType, _vehSpawnPoint, [], 0, "NONE"];
_vehicle = _vehicleType createVehicle _vehSpawnPoint;
diag_log "here3";
// Where is the player?

_life_dp_task_illegal_master = player createSimpleTask ["illegaldptaskmaster"];
_life_dp_task_illegal_master setSimpleTaskDescription ["Drug Trafficking", "Drug Trafficking", ""];
_life_dp_task_illegal_master setTaskState "Assigned";

_life_dp_task_start_illegal = player createSimpleTask ["illegaldptaskstart",_life_dp_task_illegal_master];
_life_dp_task_start_illegal setSimpleTaskDescription ["STR_NOTF_GetInVehicle","Get in vehicle",""];
_life_dp_task_start_illegal setTaskState "Assigned";
player setCurrentTask _life_dp_task_start_illegal;
["DeliveryAssigned", [format [localize "STR_NOTF_GetInVehicle"]]] call BIS_fnc_showNotification;

if (_vehicle isEqualTo null) exitWith {}; // catch

waitUntil {(vehicle player) isEqualTo _vehicle};
_life_dp_task_start_illegal setTaskState "Succeeded";

_life_dp_task_pickup_illegal = player createSimpleTask ["illegaldptaskpickup",_life_dp_task_illegal_master];
_life_dp_task_pickup_illegal setSimpleTaskDescription [[format ["STR_NOTF_DPTask"]],"Drug Trafficking",""];
_life_dp_task_pickup_illegal setSimpleTaskDestination _pickupPointPos;
_life_dp_task_pickup_illegal setTaskState "Assigned";
player setCurrentTask _life_dp_task_pickup_illegal;
["DeliveryAssigned", [format [localize "STR_NOTF_DPStart"]]] call BIS_fnc_showNotification;

waitUntil {(_vehicle distance _pickupPointPos) < 250;};

package = createVehicle [_containerType, _pickupPointPos, [], 0, "NONE"];
package allowDamage false;

diag_log format ["::New Arma:: %1 has been spawned at %2",_containerType,_pickupPointPos];

waitUntil {((_vehicle distance _pickupPointPos) < 10) && ((speed _vehicle) < 1)};
_loadPackage = {
  deleteVehicle package;
  packageLoaded = true;
};
package addAction ["Load into vehicle",_loadPackage];
waitUntil { packageLoaded isEqualTo true };

_life_dp_task_pickup_illegal setTaskState "Succeeded";

_life_dp_task_dropoff_illegal = player createSimpleTask ["dptaskfinal", _life_dp_task_illegal_master];
_life_dp_task_dropoff_illegal setSimpleTaskDescription ["STR_NOTF_DPDropoff","Drug Trafficking",""];
_life_dp_task_dropoff_illegal setSimpleTaskDestination _dropoffPointPos;
_life_dp_task_dropoff_illegal setTaskState "Assigned";
player setCurrentTask _life_dp_task_dropoff_illegal;
["DeliveryAssigned", [format [localize "STR_NOTF_DPDropoff"]]] call BIS_fnc_showNotification;

waitUntil {((_vehicle distance _dropoffPoint < 15) && (speed _vehicle <1));};

package = createVehicle [_containerType,_pickupPointPos, [], 0, "NONE"];
package allowDamage false;

_life_dp_task_final_illegal = player createSimpleTask ["dptaskfinalillegal",life_dp_task_illegal_master];
_life_dp_task_final_illegal setSimpleTaskDescription [[format ["STR_NOTF_DPMoveAway"]], "Drug Trafficking", ""];
_life_dp_task_final_illegal setSimpleTaskDestination _vehicle;
_life_dp_task_final_Illegal setTaskState "Assigned";
player setCurrentTask _life_dp_task_final_illegal;
["DeliveryAssigned",[format[localize "STR_NOTF_DPMoveAway"]]] call BIS_fnc_showNotification;

waitUntil {(player distance _dropoffPointPos > 15)};
deleteVehicle package;

// Determines reward via weird cascading thing, who knows if it will work.
if (life_gcrime_temp <= 40) then {
  _reward = 350000;
};
if (life_gcrime_temp < 30) then {
  _reward = 300000;
};
if (life_gcrime_temp < 20) then {
  _reward = 275000;
};
if (life_gcrime_temp < 10) then {
  _reward = 250000;
};

// Another cascading thing that modifies the reward based on how many police officers were online at the start of the mission.
if (_copCount < 10) then {};
if (_copCount > 10) then {
  _reward = _reward * 1.25
};
if (_copCount > 20) then {
  _reward = _reward * 1.5;
};
if (_copCount > 30) then {
  _reward = _reward * 2;
};

// Update CASH and level (if applicable)
CASH = CASH + _reward;
[0] call SOCK_fnc_updatePartial;

if (life_gcrime_temp isEqualTo 40) then {
  hint "Leveling progress was not earned as you are currently at the maximum gang crime level (40)";
} else {
  life_gcrime_temp = life_gcrime_temp + 1;
  [15] call SOCK_fnc_updatePartial;
};
