#include "..\..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_getDPMission.sqf

  Description:

*/
private ["_markerArray","_level","_level","_prestigeLevel","_missionFailOne","_missionFailTwo","_missionFailThree","_vehicleType","_containerType","_civPrestigeLevel","_exitLoopOne","_exitLoopOne","_pickupPoint","_pickupPointPos","_dropoffPoint","_dropoffPointPos","_pickupCity","_dropoffCity","_randomPoint","_vehicle","_loadPackage","_player","_vehSpawnPoint","_baseDistance"];
diag_log " ////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						 	  		 	Script created by Glaedar @ newarma.life  	        	   						 	   // ";
diag_log " //	 						Do not use without the express written permission of the author			  		 	     // ";
diag_log " //	   											     admin@newarma.life        	                   									 // ";
diag_log " ////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function getDPMission called";

_markerArray = LIFE_SETTINGS(getArray, "delivery_points");


_baseDistance = 1000;
_exitLoopOne = false;
_exitLoopTwo = false;

// Master methods for failMission.
_missionFailOne = {
  diag_log "::New Arma:: Failed: Delivery already in progress";
  hint "You must finish your current delivery mission before trying to start another one";
  systemchat "You must finish your current delivery mission before trying to start another one";
};

_missionFailTwo = {
  diag_log "::New Arma:: Failed: Vehicles blocking the spawn point";
  hint "There is a vehicle blocking the spawn point, contact a police officer for assistance";
  systemchat "There is a vehicle blocking the spawn point, contact a police officer for assistance";
};

_missionFailThree = {
  diag_log "::New Arma:: Failed: Not close to a delivery center";
};

if (life_dp_in_progress) exitWith { _missionFailOne;};

// Determines which vehicle & container is being used and how far the points will be.
switch (_level) do {
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

// Edited out temporarily while I figure out my shit regarding prestiges
/*
switch (_civPrestigeLevel) do {
  case 1: {
    _vehicleType = "C_van_02_vehicle_F";
    _containerType = "Land_PaperBox_open_full_F";
  };
  case 2: {
    _vehicleType = "C_van_02_vehicle_F";
    _containterType = "Land_PaperBox_open_full_F";
  };
};
*/

// Determines where the player is and where the vehicle will be spawning.
if (player distance jobs_centre_1 < 100) then { _vehSpawnPoint = getMarkerPos "jobs_mission_spawn_1";};
if (player distance jobs_centre_2 < 100) then { _vehSpawnPoint = getMarkerPos "jobs_mission_spawn_2";};

// Checks the spawn point to see if there is a vehicle blocking the spawn point.
//if (!(count (nearestObjects [(getMarkerPos _vehSpawnPoint), [], 10]) isEqualTo 0)) exitWith { _missionFailTwo;};

// Selects a random, eligble pickup location
while {_exitLoopOne isEqualTo false} do {
  _pickupPoint = _markerArray call BIS_fnc_selectRandom;
  _randomPoint = [[[_pickupPoint, 100]], []] call BIS_fnc_randomPos;
  _pickupPointPos = getMarkerPos _pickupPoint;

  if ((count (nearestObjects [_randomPoint, [], 8]) isEqualTo 0) && !(isOnRoad _randomPoint)) then { //&& ((_pickupPointPos distance _pickupPoint) > (_baseDistance * _distanceModifier))) then {

    _exitLoopOne = true;


    diag_log format ["::New Arma:: Successfully found a clear place to spawn at %1, located at coordinates %2",_pickupPoint,_pickupPointPos];
  };
};

// Selects a random dropoff location
while {_exitLoopTwo isEqualTo false} do {
  _dropoffPoint = _markerArray call BIS_fnc_selectRandom;
  _randomPoint = [[[_dropoffPoint, 100]], []] call BIS_fnc_randomPos;
  _dropoffPointPos = getMarkerPos _dropoffPoint;

  if ((count (nearestObjects [_randomPoint, [], 8]) isEqualTo 0) && !(isOnRoad _randomPoint)) then { // && ((_dropoffPointPos distance _pickupPoint) > (_baseDistance * _distanceModifier))) then { //additionally !(_dropoffPoint isEqualTo _pickupPoint) &&
    _exitLoopTwo = true;
    diag_log format ["::New Arma:: Dropoff location is at %1, located at coordinates %2",_dropoffPoint,_dropoffPointPos];
  };
};
diag_log format ["%1",_vehicleType];
_vehicle = _vehicleType createVehicle _vehSpawnPoint;

// Creates the master task and the first child task
life_dp_task_master = player createSimpleTask ["dptaskmaster"];
life_dp_task_master setSimpleTaskDescription ["Delivery Mission", "Delivery Mission",""];
life_dp_task_master setTaskState "Assigned";

// Creates a task for the player to get in the vehicle
life_dp_task_start = player createSimpleTask ["dptaskstart"];
life_dp_task_start setSimpleTaskDescription ["STR_NOTF_GetInVehicle","Get in vehicle",""];
life_dp_task_start setTaskState "Assigned";
player setCurrentTask life_dp_task_start;
["DeliveryAssigned", [format [localize "STR_NOTF_GetInVehicle"]]] call BIS_fnc_showNotification;

waitUntil {(vehicle player) isEqualTo _vehicle};

life_dp_task_start setTaskState "Succeeded";

life_dp_task_pickup = player createSimpleTask ["dptaskpickup", life_dp_task_master];
life_dp_task_pickup setSimpleTaskDescription [[format ["STR_NOTF_DPTask"]],"Delivery Mission",""];
life_dp_task_pickup setSimpleTaskDestination _pickupPointPos;
life_dp_task_pickup setTaskState "Assigned";
player setCurrentTask life_dp_task_pickup;
["DeliveryAssigned", [format [localize "STR_NOTF_DPStart"]]] call BIS_fnc_showNotification;

waitUntil {(_vehicle distance _pickupPointPos) < 250;};

package = createVehicle [_containerType, _pickupPointPos, [], 0, "NONE"];
package allowDamage false;
//package localize [format["%1's package",_playerName]];
diag_log format ["::New Arma:: %1 has been spawned at %2",_containerType,_pickupPointPos];

waitUntil {((_vehicle distance _pickupPointPos) < 10) && ((speed _vehicle) < 1) };
_loadPackage = {
  deleteVehicle package;

  packageLoaded = true;
};
package addAction ["Load into vehicle",_loadPackage];
waitUntil {packageLoaded isEqualTo true;};
life_dp_task_pickup setTaskState "Succeeded";

life_dp_task_dropoff = player createSimpleTask ["dptaskdropoff", life_dp_task_master];
life_dp_task_dropoff setSimpleTaskDescription [[format ["STR_NOTF_DPDropoff",_dropoffCity]],"Delivery Mission",""];
life_dp_task_dropoff setSimpleTaskDestination _dropoffPointPos;
life_dp_task_dropoff setTaskState "Assigned";
player setCurrentTask life_dp_task_dropoff;
["DeliveryAssigned", [format [localize "STR_NOTF_DPDropoff",_pickupCity]]] call BIS_fnc_showNotification;


waitUntil {((_vehicle distance _dropoffPoint < 10) && (speed _vehicle < 1));};
package2 = createVehicle [_containerType, _pickupPointPos, [], 0, "NONE"];
package2 allowDamage false;


life_dp_task_final = player createSimpleTask ["dptaskfinal", life_dp_task_master];
life_dp_task_final setSimpleTaskDescription [[format ["STR_NOTF_DPMoveAway"]], "Delivery Mission",""];
life_dp_task_final setSimpleTaskDestination _vehicle;
life_dp_task_final setTaskState "Assigned";
player setCurrentTask life_dp_task_final;
["DeliveryAssigned", [format[localize "STR_NOTF_DPMoveAway"]]] call BIS_fnc_showNotification;


// Despawn truck and package allow option to fast travel?
waitUntil {(player distance _dropoffPoint > 15)};
deleteVehicle package2;

//insert reward

//_reward
