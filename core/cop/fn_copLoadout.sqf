/*
    File: fn_copLoadout.sqf
    Author: Bryan "Tonic" Boardwine
    Edited: Itsyuka

    Description:
    Loads the cops out with the default gear.
*/
private ["_handle"];
_handle = [] spawn life_fnc_stripDownPlayer;
waitUntil {scriptDone _handle};

//Load player with default cop gear.
if ((str(player) in ["swat_1","swat_2","swat_3","swat_4","swat_5","swat_6","swat_7","swat_8","swat_9","swat_10","swat_11","swat_12","swat_13","swat_14","swat_15","swat_16","swat_17","swat_18","swat_19"])) then {
	player addUniform "U_B_CTRG_1"; //edited 22/08
	player addVest "V_Rangemaster_belt";
	player addMagazine "16Rnd_9x21_Mag";
	player addWeapon "hgun_P07_snds_F";
	player addMagazine "16Rnd_9x21_Mag";
	player addMagazine "16Rnd_9x21_Mag";
	player addMagazine "16Rnd_9x21_Mag";
	player addMagazine "16Rnd_9x21_Mag";
	player addMagazine "16Rnd_9x21_Mag";
}
	else {
		player addWeapon "hgun_P07_snds_F";
	};
	

/* ITEMS */
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemGPS";

[] call life_fnc_playerSkins;
[] call life_fnc_saveGear;
