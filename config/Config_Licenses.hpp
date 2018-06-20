/*
*    class:
*        variable = Variable Name
*        displayName = License Name
*        price = License Price
*        illegal = Illegal License
*        side = side indicator
*/
class Licenses {
    //Civilian Licenses
    class uber {
        variable = "uber";
        displayName = "STR_Licence_Uber";
        price = 20000;
        side = "civ";
    };
    class driver {
        variable = "driver";
        displayName = "STR_License_Driver";
        price = 500;
        illegal = false;
        side = "civ";
    };

    class boat {
        variable = "boat";
        displayName = "STR_License_Boat";
        price = 1000;
        illegal = false;
        side = "civ";
    };

    class pilot {
        variable = "pilot";
        displayName = "STR_License_Pilot";
        price = 25000;
        illegal = false;
        side = "civ";
    };

    class trucking {
        variable = "trucking";
        displayName = "STR_License_Truck";
        price = 20000;
        illegal = false;
        side = "civ";
    };

    class gun {
        variable = "gun";
        displayName = "STR_License_Firearm";
        price = 10000;
        illegal = false;
        side = "civ";
    };

    class dive {
        variable = "dive";
        displayName = "STR_License_Diving";
        price = 2000;
        illegal = false;
        side = "civ";
    };

    class home {
        variable = "home";
        displayName = "STR_License_Home";
        price = 75000;
        illegal = false;
        side = "civ";
    };

    //Processing Licenses
    class oil {
        variable = "oil";
        displayName = "STR_License_Oil";
        price = 10000;
        illegal = false;
        side = "civ";
    };

    class diamond {
        variable = "diamond";
        displayName = "STR_License_Diamond";
        price = 35000;
        illegal = false;
        side = "civ";
    };

    class salt {
        variable = "salt";
        displayName = "STR_License_Salt";
        price = 12000;
        illegal = false;
        side = "civ";
    };

    class sand {
        variable = "sand";
        displayName = "STR_License_Sand";
        price = 14500;
        illegal = false;
        side = "civ";
    };

    class iron {
        variable = "iron";
        displayName = "STR_License_Iron";
        price = 9500;
        illegal = false;
        side = "civ";
    };

    class copper {
        variable = "copper";
        displayName = "STR_License_Copper";
        price = 8000;
        illegal = false;
        side = "civ";
    };

    class cement {
        variable = "cement";
        displayName = "STR_License_Cement";
        price = 6500;
        illegal = false;
        side = "civ";
    };

    class medmarijuana {
        variable = "medmarijuana";
        displayName = "STR_License_Medmarijuana";
        price = 15000;
        illegal = false;
        side = "civ";
    };

    //Illegal Licenses
    class cocaine {
        variable = "cocaine";
        displayName = "STR_License_Cocaine";
        price = 30000;
        illegal = true;
        side = "civ";
    };

    class heroin {
        variable = "heroin";
        displayName = "STR_License_Heroin";
        price = 25000;
        illegal = true;
        side = "civ";
    };

    class marijuana {
        variable = "marijuana";
        displayName = "STR_License_Marijuana";
        price = 19500;
        illegal = true;
        side = "civ";
    };

    class rebel {
        variable = "rebel";
        displayName = "STR_License_Rebel";
        price = 75000;
        illegal = true;
        side = "civ";
    };

    //Cop Licenses
    class cAir {
        variable = "cAir";
        displayName = "STR_License_Pilot";
        price = 15000;
        illegal = false;
        side = "cop";
    };

    class cg {
        variable = "cg";
        displayName = "STR_License_CG";
        price = 8000;
        illegal = false;
        side = "cop";
    };

    //Medic Licenses
    class mAir {
        variable = "mAir";
        displayName = "STR_License_Pilot";
        price = 15000;
        illegal = false;
        side = "med";
    };

	//OPFOR Licences - ADDED 17/08
	class oSpecial {
		variable = "oSpecial";
		displayName = "Special Equipment Licence";
		price = 999999;
		illegal = false;
		side = "opfor";
	};

	class oMarksman {
		variable = "oMarksman";
		displayName = "Marksman Training";
		price = 999999;
		illegal = false;
		side = "opfor";
	};

	class oHeavy {
		variable = "oHeavy";
		displayName = "Heavy Weaponry Training";
		price = 999999;
		illegal = false;
		side = "opfor";
	};

	class oSniper {
		variable = "oSniper";
		displayName = "Sniper Rifle Training";
		price = 999999;
		illegal = false;
		side = "opfor";
	};

	//Swat Licences ADDED 04/09
	class sSpecial {
		variable = "sSpecial";
		displayName = "Special Equipment Licence";
		price = 999999;
		illegal = false;
		side = "cop";
	};

	class sMarksman {
		variable = "sMarksman";
		displayName = "Marksman Training";
		price = 999999;
		illegal = false;
		side = "cop";
	};

	class sHeavy {
		variable = "sHeavy";
		displayName = "Heavy Weaponry Training";
		price = 999999;
		illegal = false;
		side = "cop";
	};

	class sSniper {
		variable = "sSniper";
		displayName = "Sniper Rifle Training";
		price = 999999;
		illegal = false;
		side = "cop";
	};
};
