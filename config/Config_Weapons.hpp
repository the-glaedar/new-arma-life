/*
*    FORMAT:
*        STRING (Conditions) - Must return boolean :
*            String can contain any amount of conditions, aslong as the entire
*            string returns a boolean. This allows you to check any levels, licenses etc,
*            in any combination. For example:
*                "call life_coplevel && license_civ_someLicense"
*            This will also let you call any other function.
*
*
*    ARRAY FORMAT:
*        0: STRING (Classname): Item Classname
*        1: STRING (Nickname): Nickname that will appear purely in the shop dialog
*        2: SCALAR (Buy price)
*        3: SCALAR (Sell price): To disable selling, this should be -1
*        4: STRING (Conditions): Same as above conditions string
*
*    Weapon classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Weapons
*    Item classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items
*
*/
class WeaponShops {
    //Armory Shops
    class gun {
        name = "Firearms Shop";
        side = "civ";
        conditions = "license_civ_gun";
        items[] = {
            { "hgun_Rook40_F", "", 6500, 3250, "" },
            { "hgun_Pistol_01_F", "", 7000, 3500, "" }, //Apex DLC
            { "hgun_Pistol_heavy_02_F", "", 9850, 4925, "" },
            { "hgun_ACPC2_F", "", 11500, 5750, "" },
            { "SMG_05_F", "", 18000, 9000, "" }, //Apex DLC
            { "hgun_PDW2000_F", "", 20000, 10000, "" }
        };
        mags[] = {
            { "16Rnd_9x21_Mag", "", 125, 60, "" },
            { "6Rnd_45ACP_Cylinder", "", 150, 75, "" },
            { "9Rnd_45ACP_Mag", "", 200, 100, "" },
            { "30Rnd_9x21_Mag", "", 250, 125, "" },
            { "30Rnd_9x21_Mag_SMG_02", "", 250, 125, "" }, //Apex DLC
            { "10Rnd_9x21_Mag", "", 250, 125, "" } //Apex DLC
        };
        accs[] = {
            { "optic_ACO_grn_smg", "", 2500, 1250, "" }
        };
    };

    class rebel {
        name = "Rebel Armoury";
        side = "civ";
        conditions = "license_civ_rebel";
        items[] = {
            { "arifle_TRG20_F", "", 25000, 12500, "" },
            { "arifle_Katiba_F", "", 30000, 15000, "" },
            { "srifle_DMR_01_F", "", 50000, 25000, "" },
            { "arifle_SDAR_F", "", 20000, 10000, "" },
            { "arifle_AK12_F", "", 22000, 11000, "" }, //Apex DLC
            { "arifle_AKS_F", "", 22000, 11000, "" }, //Apex DLC
            { "arifle_AKM_F", "", 22000, 11000, "" }, //Apex DLC
            { "arifle_ARX_blk_F", "", 22000, 11000, "" }, //Apex DLC
            { "arifle_SPAR_01_blk_F", "", 33000, 16500, "" }, //Apex DLC
            { "arifle_CTAR_blk_F", "", 30000, 15000, "" } //Apex DLC
        };
        mags[] = {
            { "30Rnd_556x45_Stanag", "", 300, 150, "" },
            { "30Rnd_762x39_Mag_F", "", 300, 150, "" }, //Apex DLC
            { "30Rnd_545x39_Mag_F", "", 300, 150, "" }, //Apex DLC
            { "30Rnd_65x39_caseless_green", "", 275, 140, "" },
            { "10Rnd_762x54_Mag", "", 500, 250, "" },
            { "20Rnd_556x45_UW_mag", "", 125, 60, "" },
            { "30Rnd_580x42_Mag_F", "", 125, 60, "" } //Apex DLC
        };
        accs[] = {
            { "optic_ACO_grn", "", 3500, 1750, "" },
            { "optic_Holosight", "", 3600, 1800, "" },
            { "optic_Hamr", "", 7500, 3750, "" },
            { "acc_flashlight", "", 1000, 500, "" }
        };
    };

    class gang {
        name = "Hideout Armoury";
        side = "civ";
        conditions = "";
        items[] = {
            { "hgun_Rook40_F", "", 1500, 750, "" },
            { "hgun_Pistol_heavy_02_F", "", 2500, 1250, "" },
            { "hgun_ACPC2_F", "", 4500, 2250, "" },
            { "hgun_PDW2000_F", "", 9500, 4750, "" }
        };
        mags[] = {
            { "16Rnd_9x21_Mag", "", 125, 60, "" },
            { "6Rnd_45ACP_Cylinder", "", 150, 75, "" },
            { "9Rnd_45ACP_Mag", "", 200, 100, "" },
            { "30Rnd_9x21_Mag", "", 250, 125, "" }
        };
        accs[] = {
            { "optic_ACO_grn_smg", "", 950, 475, "" }
        };
    };

    //Basic Shops
    class genstore {
        name = "Altis General Store";
        side = "civ";
        conditions = "";
        items[] = {
            { "Binocular", "", 150, 75, "" },
            { "ItemGPS", "", 100, 50, "" },
            { "ItemMap", "", 50, 25, "" },
            { "ItemCompass", "", 50, 25, "" },
            { "ItemWatch", "", 50, 25, "" },
            { "FirstAidKit", "", 150, 75, "" },
            { "NVGoggles", "", 2000, 1000, "" },
            { "Chemlight_red", "", 300, 150, "" },
            { "Chemlight_yellow", "", 300, 150, "" },
            { "Chemlight_green", "", 300, 150, "" },
            { "Chemlight_blue", "", 300, 150, "" }
        };
        mags[] = {};
        accs[] = {};
    };

    class f_station_store {
        name = "Altis Fuel Station Store";
        side = "";
        conditions = "";
        items[] = {
            { "Binocular", "", 750, 75, "" },
            { "ItemGPS", "", 500, 50, "" },
            { "ItemMap", "", 250, 25, "" },
            { "ItemCompass", "", 250, 25, "" },
            { "ItemWatch", "", 250, 25, "" },
            { "FirstAidKit", "", 750, 75, "" },
            { "NVGoggles", "", 10000, 1000, "" },
            { "Chemlight_red", "", 1500, 150, "" },
            { "Chemlight_yellow", "", 1500, 150, "" },
            { "Chemlight_green", "", 1500, 150, "" },
            { "Chemlight_blue", "", 1500, 150, "" }
        };
        mags[] = {};
        accs[] = {};
    };

    //Cop Shops
    class cop_basic {
        name = "Altis Cop Shop";
        side = "cop";
        conditions = "";
        items[] = {
            { "Binocular", "", 150, 75, "" },
            { "ItemGPS", "", 100, 50, "" },
            { "FirstAidKit", "", 150, 75, "" },
            { "NVGoggles", "", 2000, 1000, "" },
            { "HandGrenade_Stone", $STR_W_items_Flashbang, 1700, 850, "" },
            { "hgun_P07_snds_F", $STR_W_items_StunPistol, 2000, 1000, "" },
            { "arifle_SDAR_F", $STR_W_items_TaserRifle, 20000, 10000, "" },
            { "hgun_P07_F", "", 7500, 3750, "" },
            { "hgun_P07_khk_F", "", 7500, 3750, "" }, //Apex DLC
            { "hgun_Pistol_heavy_01_F", "", 9500, 4750, "call life_coplevel >= 1" },
            { "SMG_02_ACO_F", "", 30000, 15000, "call life_coplevel >= 2" },
            { "arifle_MX_F", "", 35000, 17500, "call life_coplevel >= 2" },
            { "hgun_ACPC2_F", "", 17500, 8750, "call life_coplevel >= 3" },
            { "arifle_MXC_F", "", 30000, 15000, "call life_coplevel >= 3" },
            { "srifle_DMR_07_blk_F", "", 32000, 16000, "call life_coplevel >= 3" } //Apex DLC Sniper
        };
        mags[] = {
            { "16Rnd_9x21_Mag", "", 125, 60, "" },
            { "20Rnd_556x45_UW_mag", $STR_W_mags_TaserRifle, 125, 60, "" },
            { "11Rnd_45ACP_Mag", "", 130, 65, "call life_coplevel >= 1" },
            { "30Rnd_65x39_caseless_mag", "", 130, 65, "call life_coplevel >= 2" },
            { "30Rnd_9x21_Mag", "", 250, 125, "call life_coplevel >= 2" },
            { "9Rnd_45ACP_Mag", "", 200, 100, "call life_coplevel >= 3" },
            { "20Rnd_650x39_Cased_Mag_F", "", 200, 100, "call life_coplevel >= 3" } //Apex DLC
        };
        accs[] = {
            { "muzzle_snds_L", "", 650, 325, "" },
            { "optic_MRD", "", 2750, 1375, "call life_coplevel >= 1" },
            { "acc_flashlight", "", 750, 375, "call life_coplevel >= 2" },
            { "optic_Holosight", "", 1200, 600, "call life_coplevel >= 2" },
            { "optic_Arco", "", 2500, 1250, "call life_coplevel >= 2" },
            { "muzzle_snds_H", "", 2750, 1375, "call life_coplevel >= 2" }
        };
    };

	class sec_basic {
		name = "Malden Security Shop";
		side = "cop";
		conditions = ""; //life_fnc_callCopLevel...
		items[] = {};
		mags[] = {};
		accs[] = {};
	};

    //Medic Shops
    class med_basic {
        name = "store";
        side = "med";
        conditions = "";
        items[] = {
            { "ItemGPS", "", 100, 50, "" },
            { "Binocular", "", 150, 75, "" },
            { "FirstAidKit", "", 150, 75, "" },
            { "NVGoggles", "", 1200, 600, "" }
        };
        mags[] = {};
        accs[] = {};
    };
	//SWAT Shop
	class swat_basic {
		name = "Armoury"; //convert to string
		side = "cop";
		conditions = "call life_swatlevel >=1";
		items[] = {
			{ "ItemGPS", "", 100, -1, "" },
			{ "FirstAidKit", "", 150, -1, "" },
            { "Binocular", "", 150, -1, "" },
			{ "NVGoggles_OPFOR", "Night Vision Goggles", 400, -1, "" },
			{ "Rangefinder", "", 150, -1, "licence_cop_sMarksman || call life_swatlevel >=3" },
			{ "Laserdesignator_03", "Laser Designator", 1000, -1, "licence_cop_sSniper || call life_swatlevel >=4" },
			{ "B_UavTerminal", "UAV Terminal", 100, -1, "call life_coplevel >=5" },
			{ "hgun_Pistol_01_F", "PM Pistol", 8000, -1, "" },
			{ "arifle_AK12_F", "AK-12 [SWAT]", 30000, -1, "" }, //AK-12 Basic Weapon
			{ "arifle_AK12_GL_F", "AK-12 GL [SWAT]", 60000, -1, "call life_swatlevel >=3" }, //AK-12 GL
			{ "LMG_Mk200_F", "Mk200 LMG [SWAT]", 40000, -1, "licence_cop_sHeavy || call life_swatlevel >=4" },
			{ "srifle_DMR_01_F", "Rahim [SWAT]", 40000, -1, "licence_cop_sMarksman || call life_swatlevel >=4" },
			{ "srifle_LRR_F", "M320 LRR [SWAT]", 50000, -1, "licence_cop_sSniper || call life_swatlevel >=4" },
			{ "launch_I_Titan_F", "AA Launcher [SWAT]", 75000, -1, "call life_swatlevel >=4" },
			{ "launch_RPG32_F", "RPG Launcher [SWAT]", 60000, -1, "call life_swatlevel >=4 || licence_cop_sSpecial" }
		};
		mags[] = {
			{ "10Rnd_9x21_Mag", "PM 10rd Tracer", 15, -1, "" },
			{ "30Rnd_762x39_Mag_Tracer_F", "AK-12 30rd Tracer", 25, -1, "" },
			{ "1Rnd_Smoke_Grenade_shell", "AK-12 Smoke Grenade (GL)", 100, -1, "call life_swatlevel >= 3" },
			{ "1Rnd_HE_Grenade_shell", "AK-12 HE Grenade (GL)", 500, -1, "call life_swatlevel >= 4" },
			{ "200Rnd_65x39_Belt_Tracer_Yellow", "Mk200 200rd Tracer", 80, -1, "licence_cop_sHeavy || call life_swatlevel >= 3" },
			{ "10Rnd_762x54_Mag", "Rahim 10rd Tracerless", 40, -1, "licence_cop_sMarksman || call life_swatlevel >=3" },
			{ "7Rnd_408_Mag", "M320 7rd Tracerless", 80, -1, "licence_cop_sSniper || call life_swatlevel >=3" },
			{ "30Rnd_556x45_Stanag_red", "SDAR 30Rnd Tracer", 25, -1, "licence_cop_sSpecial || call life_swatlevel >=3" },
			{ "Titan_AA", "Titan Anti-Air Missile", 1000, -1, "call life_swatlevel	>=4" },
			{ "RPG32_F", "RPG 32 Anti-Personnel Missile", 1000, -1, "call life_swatlevel >=4" }
		};
		accs[] = {
			{ "optic_Hamr", "", 150, -1, "" },
			{ "optic_ARCO", "", 150, -1, "" },
			{ "optic_DMS", "", 200, -1, "licence_cop_sMarksman || call life_swatlevel >= 3" },
			{ "optic_MOS", "", 200, -1, "licence_cop_sMarksman || call life_swatlevel >= 3" },
			{ "optic_NVS", "", 400, -1, "licence_cop_sMarksman || licence_cop_sSniper || call life_swatlevel >= 3" },
			{ "optic_LRPS", "", 400, -1, "licence_cop_sSniper || call life_swatlevel >= 3" },
			{ "optic_KHS_blk", "", 350, -1, "licence_cop_sSniper || call life_swatlevel >= 3" },
			{ "muzzle_snds_L", "", 300, -1, "" },
			{ "muzzle_snds_H", "", 300, -1, "" },
			{ "muzzle_snds_B", "", 300, -1, "licence_opfor_sMarksman || call life_swatlevel >= 3" },
			{ "acc_pointer_IR", "", 50, -1, "" },
			{ "bipod_03_F_blk", "Bipod", 50, -1, "" }
		};
	};

	//OPFOR Shop
	class opfor_basic {
		name = "Armoury"; //convert to string
		side = "";
		conditions = "";
		items[] = {
			{ "ItemGPS", "", 100, -1, "" },
			{ "FirstAidKit", "", 150, -1, "" },
      { "Binocular", "", 150, -1, "" },
			{ "NVGoggles_INDEP", "Night Vision Goggles", 400, -1, "" },
			{ "Rangefinder", "", 150, -1, "licence_opfor_oMarksman || call life_opforlevel >=3" },
			{ "Laserdesignator_03", "Laser Designator", 1000, -1, "licence_opfor_oSniper || call life_opforlevel >=3" },
			{ "O_UavTerminal", "UAV Terminal", 100, -1, "call life_opforlevel >=5" },
			{ "hgun_Rook40_F", "Rook-40 Pistol", 8000, -1, ""},
			{ "hgun_Pistol_heavy_02_F", "Zubr Revolver", 4000, -1, "call life_opforlevel >=3" },
			{ "arifle_MX_Black_F", "MX [NMRF]", 30000, -1, "" }, //MX (Black) [PVT]
			{ "arifle_MXC_Black_F", "MX Compact [NMRF]", 25000, -1, "call life_opforlevel >= 3 || licence_opfor_oSpecial" }, //MXC [Spec & ETC]
			{ "arifle_MXM_Black_F", "MX Marksman [NMRF]", 40000, -1, "licence_opfor_oMarksman" },
			{ "srifle_EBR_F", "Mk18 DMR [NMRF]", 35000, -1, "licence_opfor_oMarksman" },
			{ "arifle_MX_SW_Black_F", "MX SW [NMRF]", 40000, -1, "licence_opfor_oHeavy" },
			{ "arifle_SDAR_F", "SDAR Underwater Rifle [NMRF]", 25000, -1, "licence_opfor_oSpecial" },
			{ "srifle_LRR_F", "M320 LRR [NMRF]", 50000, -1, "licence_opfor_oSniper" },
			{ "launch_I_Titan_F", "AA Launcher [NMRF]", 75000, -1, "call life_opforlevel >=4" },
			{ "launch_RPG32_F", "RPG Launcher [NMRF]", 60000, -1, "call life_opforlevel >=3 || licence_opfor_oSpecial" }
		};
		mags[] = {
			{ "30Rnd_9x21_Red_Mag", "Rook-40 30rd Tracer", 15, -1, "" },
			{ "6Rnd_45ACP_Cylinder", "Zubr 6rd Cylinder", 10, -1, "call life_opforlevel >=3" },
			{ "30Rnd_65x39_caseless_mag_Tracer", "MX 30rd Tracer", 25, -1, "" },
			{ "100Rnd_65x39_caseless_mag_Tracer", "MX SW 100Rnd Tracer", 80, -1, "licence_opfor_oHeavy" },
			{ "30Rnd_65x39_caseless_mag", "MXM 30Rnd Tracerless", 80, -1, "licence_opfor_oMarksman" },
			{ "20Rnd_762x51_Mag", "Mk18 20Rnd Tracerless", 40, -1, "licence_opfor_oMarksman" },
			{ "7Rnd_408_Mag", "M320 7rd Tracerless", 80, -1, "licence_opfor_oSniper || call_life_opforlevel >=3" },
			{ "30Rnd_556x45_Stanag_red", "SDAR 30Rnd Tracer", 25, -1, "licence_opfor_oSpecial" },
			{ "Titan_AA", "Titan Anti-Air Missile", 1000, -1, "call life_opforlevel	>=4" },
			{ "RPG32_F", "RPG 32 Anti-Personnel Missile", 1000, -1, "call life_opforlevel >=4" }
		};
		accs[] = {
			{ "optic_Hamr", "", 150, -1, "" },
			{ "optic_ARCO", "", 150, -1, "" },
			{ "optic_DMS", "", 200, -1, "licence_opfor_oMarksman" },
			{ "optic_MOS", "", 200, -1, "licence_opfor_oMarksman" },
			{ "optic_NVS", "", 400, -1, "licence_opfor_oMarksman || licence_opfor_oSniper" },
			{ "optic_LRPS", "", 400, -1, "licence_opfor_oSniper" },
			{ "optic_KHS_blk", "", 350, -1, "licence_opfor_oSniper" },
			{ "muzzle_snds_L", "", 300, -1, "" },
			{ "muzzle_snds_H", "", 300, -1, "" },
			{ "muzzle_snds_B", "", 300, -1, "licence_opfor_oMarksman" },
			{ "acc_pointer_IR", "", 50, -1, "" },
			{ "bipod_03_F_blk", "Bipod", 50, -1, "" },
		};
	};
};
