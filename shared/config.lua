Rewards = {
    ["Statuettes"] = {
        [1] = { Item = "sns_body", Amount = 1 },
        [2] = { Item = "sns_barrel", Amount = 1 },
        [3] = { Item = "sns_accessories", Amount = 1 },
        [4] = { Item = "pistol_barrel", Amount = 1 },
        [5] = { Item = "currency_eur", Amount = math.random(4000, 4200) },
        [6] = { Item = "horse_statue", Amount = 1 },
        [7] = { Item = "cow_statue", Amount = 1 },
        [8] = { Item = "motherboard", Amount = 1 },
    },
    ["Lockers"] = {
        [1] = { Item = "advancedlockpick", Amount = 1 },
        [2] = { Item = "tablet", Amount = 1 },
        [3] = { Item = "iphone", Amount = 1 },
        [4] = { Item = "fitbit", Amount = 1 },
        [5] = { Item = "laptop", Amount = 1 },
        [6] = { Item = "currency_cny", Amount = math.random(8000, 8500) },
        [7] = { Item = "motherboard", Amount = 1 },
    },
    ["Laptop"] = {
        [1] = { Item = "computer", Amount = 1 },
    },
    ["TV"] = {
        [1] = { Item = "bigtv", Amount = 1 },
    },
    ["Microwave"] = {
        [1] = { Item = "microwave", Amount = 1 },
    },
}

HouseRobbery = {
    Misc = {
        CopsRequired = 2,
        EnableCopsDispatch = true,

        MaxFailsPerHeist = 5,
    },

    Main = {
        Debug = false,

        Language = "en",

        Framework = "qb",   -- 'qb', 'esx' or 'standalone'
        Target = "qb",      -- 'ox' or 'qb'
        ProgressBar = "qb", -- 'ox' or 'qb'

        PoliceJobName = "police",
    },

    RequiredItems = {
        ["OutsidePanel"] = {
            Item = "lockpick",
            Amount = 1,
            RemoveItem = true,
        },
        ["Lockers"] = {
            Item = "lockpick",
            Amount = 1,
            RemoveItem = false,
        },
    },

    Locations = {
        ["Micheal"] = {
            Misc = {
                IsRobbed = false,
                IsRobberyActive = false,
            },

            OutsidePanel = { Coords = vector3(-813.4289, 183.5657, 72.1186), AnimationCoords = vector4(-813.76, 184.46, 72.47, 200.93), IsBusy = false, IsDone = false },

            Lockers = {
                [1] = { Coords = vector3(-811.0153, 178.1929, 72.4362), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [2] = { Coords = vector3(-814.3943, 176.9211, 72.4403), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [3] = { Coords = vector3(-808.3466, 181.8248, 72.3635), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [4] = { Coords = vector3(-801.8688, 168.4258, 73.0633), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [5] = { Coords = vector3(-806.2806, 177.5146, 72.3712), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [6] = { Coords = vector3(-806.9181, 171.0328, 73.2375), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [7] = { Coords = vector3(-806.1937, 169.1455, 73.2388), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [8] = { Coords = vector3(-798.0388, 188.0539, 72.2693), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [9] = { Coords = vector3(-804.0131, 184.3761, 72.3989), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [10] = { Coords = vector3(-799.9255, 169.4315, 76.7719), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [11] = { Coords = vector3(-798.6863, 170.0631, 76.5232), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [12] = { Coords = vector3(-801.4957, 169.8834, 76.6432), IsBusy = false, IsDone = false, Rewards = Rewards["Laptop"] },
                [13] = { Coords = vector3(-808.3041, 174.8783, 76.4766), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [14] = { Coords = vector3(-804.5662, 169.9271, 76.1884), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [15] = { Coords = vector3(-806.3242, 169.4073, 76.415), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [16] = { Coords = vector3(-810.4894, 170.4657, 77.4364), IsBusy = false, IsDone = false, Rewards = Rewards["TV"] },
                [17] = { Coords = vector3(-811.16, 182.017, 76.6476), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [18] = { Coords = vector3(-812.037, 173.8261, 76.1427), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
            }
        },

        ["Franklink"] = {
            Misc = {
                IsRobbed = false,
                IsRobberyActive = false,
            },

            OutsidePanel = { Coords = vector3(17.6096, 543.0781, 175.6576), AnimationCoords = vector4(18.11, 543.89, 176.03, 150.83), IsBusy = false, IsDone = false },

            Lockers = {
                [1] = { Coords = vector3(-0.5245, 536.9218, 175.6943), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [2] = { Coords = vector3(-6.0736, 531.3102, 175.0684), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [3] = { Coords = vector3(-0.7254, 525.537, 174.9193), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [4] = { Coords = vector3(-2.1383, 536.1693, 175.9446), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [5] = { Coords = vector3(-10.2286, 520.0327, 174.3301), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [6] = { Coords = vector3(-11.3448, 518.1451, 174.3439), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [7] = { Coords = vector3(-12.1289, 516.8192, 174.7045), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [8] = { Coords = vector3(1.2581, 531.0052, 174.3218), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [9] = { Coords = vector3(11.8212, 528.6488, 174.3958), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [10] = { Coords = vector3(6.1273, 538.5824, 175.8802), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [11] = { Coords = vector3(-2.4359, 525.3617, 169.9363), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [12] = { Coords = vector3(-9.5593, 521.1644, 175.149), IsBusy = false, IsDone = false, Rewards = Rewards["Microwave"] },
                [13] = { Coords = vector3(9.512, 529.8558, 170.3143), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [14] = { Coords = vector3(10.6024, 527.5808, 170.3064), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [15] = { Coords = vector3(10.0635, 528.7053, 170.2984), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [16] = { Coords = vector3(3.8713, 530.2475, 175.4415), IsBusy = false, IsDone = false, Rewards = Rewards["TV"] },
                [17] = { Coords = vector3(-7.9725, 530.5948, 174.5184), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [18] = { Coords = vector3(-6.5346, 530.9829, 174.5347), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
            }
        },

        ["Trevor"] = {
            Misc = {
                IsRobbed = false,
                IsRobberyActive = false,
            },

            OutsidePanel = { Coords = vector3(-1140.7736, -1520.0577, 4.6614), AnimationCoords = vector4(-1141.39, -1518.94, 4.38, 224.40), IsBusy = false, IsDone = false },

            Lockers = {
                [1] = { Coords = vector3(-1155.1304, -1524.3246, 10.8786), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [2] = { Coords = vector3(-1151.6073, -1521.2948, 11.4338), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [3] = { Coords = vector3(-1152.5442, -1519.251, 10.2869), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [4] = { Coords = vector3(-1144.0151, -1516.2074, 10.8344), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [5] = { Coords = vector3(-1148.1514, -1519.2126, 10.2985), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [6] = { Coords = vector3(-1151.8168, -1513.549, 10.6035), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [7] = { Coords = vector3(-1147.5475, -1513.854, 10.2068), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [8] = { Coords = vector3(-1147.9537, -1510.7424, 10.1124), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [9] = { Coords = vector3(-1150.1001, -1512.2454, 10.1052), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [10] = { Coords = vector3(-1152.0957, -1521.9386, 10.749), IsBusy = false, IsDone = false, Rewards = Rewards["Microwave"] },
                [11] = { Coords = vector3(-1155.3291, -1516.9174, 10.1529), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [12] = { Coords = vector3(-1152.481, -1521.5281, 10.2153), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [13] = { Coords = vector3(-1154.2473, -1523.4298, 10.1672), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [14] = { Coords = vector3(-1161.569, -1520.1902, 10.6506), IsBusy = false, IsDone = false, Rewards = Rewards["TV"] },
            }
        },

        ["Lester"] = {
            Misc = {
                IsRobbed = false,
                IsRobberyActive = false,
            },

            OutsidePanel = { Coords = vector3(1276.5455, -1708.4906, 55.1433), AnimationCoords = vector4(1277.19, -1708.21, 54.66, 113.34), IsBusy = false, IsDone = false },

            Lockers = {
                [1] = { Coords = vector3(1272.2072, -1715.8629, 54.2734), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [2] = { Coords = vector3(1272.839, -1713.9282, 55.4177), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [3] = { Coords = vector3(1273.5856, -1713.8253, 54.7208), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [4] = { Coords = vector3(1272.161, -1711.2999, 54.3512), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [5] = { Coords = vector3(1268.2822, -1724.0316, 54.0562), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [6] = { Coords = vector3(1273.2775, -1720.0969, 54.5081), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [7] = { Coords = vector3(1276.5448, -1715.2319, 54.4417), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [8] = { Coords = vector3(1268.1824, -1710.3347, 54.8303), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [9] = { Coords = vector3(1271.2281, -1710.0421, 54.5568), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [11] = { Coords = vector3(1275.5745, -1711.4642, 54.4246), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [12] = { Coords = vector3(1272.0989, -1712.9573, 54.6236), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [13] = { Coords = vector3(1276.7539, -1712.3464, 54.8571), IsBusy = false, IsDone = false, Rewards = Rewards["TV"] },
            }
        },

        ["Franklin2"] = {
            Misc = {
                IsRobbed = false,
                IsRobberyActive = false,
            },

            OutsidePanel = { Coords = vector3(-12.26, -1426.7285, 30.6944), AnimationCoords = vector4(-12.31, -1425.75, 30.67, 188.61), IsBusy = false, IsDone = false },

            Lockers = {
                [1] = { Coords = vector3(-16.6255, -1440.5482, 30.7517), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [2] = { Coords = vector3(-12.7416, -1435.1204, 30.9133), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [3] = { Coords = vector3(-15.4141, -1440.0833, 30.9206), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [4] = { Coords = vector3(-18.647, -1440.1714, 30.8924), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [5] = { Coords = vector3(-8.9814, -1435.3978, 30.6721), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [6] = { Coords = vector3(-9.7972, -1429.488, 30.7361), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [7] = { Coords = vector3(-11.7982, -1427.4503, 31.9291), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [8] = { Coords = vector3(-9.5245, -1427.5166, 31.237), IsBusy = false, IsDone = false, Rewards = Rewards["Microwave"] },
                [9] = { Coords = vector3(-17.4155, -1430.3671, 30.9303), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [10] = { Coords = vector3(-16.137, -1430.8265, 30.5609), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [11] = { Coords = vector3(-16.6123, -1435.1615, 30.5846), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [12] = { Coords = vector3(-9.1078, -1441.6177, 31.0677), IsBusy = false, IsDone = false, Rewards = Rewards["TV"] },
                [13] = { Coords = vector3(-17.6369, -1431.8302, 31.0014), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [14] = { Coords = vector3(-16.4283, -1437.449, 31.2565), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
            }
        },

        ["Janitors"] = {
            Misc = {
                IsRobbed = false,
                IsRobberyActive = false,
            },

            OutsidePanel = { Coords = vector3(-91.5077, -11.8952, 66.3174), AnimationCoords = vector4(-91.25, -11.07, 66.40, 161.83), IsBusy = false, IsDone = false },

            Lockers = {
                [1] = { Coords = vector3(-112.3107, -7.185, 70.1022), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [2] = { Coords = vector3(-112.8519, -9.284, 70.0388), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [3] = { Coords = vector3(-108.5771, -9.6035, 70.2718), IsBusy = false, IsDone = false, Rewards = Rewards["Statuettes"] },
                [4] = { Coords = vector3(-112.8741, -7.9969, 71.0415), IsBusy = false, IsDone = false, Rewards = Rewards["Microwave"] },
                [5] = { Coords = vector3(-110.1261, -6.7746, 70.1466), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [6] = { Coords = vector3(-111.6991, -12.9207, 70.0024), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [7] = { Coords = vector3(-112.0182, -6.3814, 70.1124), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [8] = { Coords = vector3(-112.3629, -8.183, 71.6459), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [9] = { Coords = vector3(-113.7922, -12.7958, 70.0539), IsBusy = false, IsDone = false, Rewards = Rewards["Lockers"] },
                [10] = { Coords = vector3(-114.2549, -12.4781, 70.6361), IsBusy = false, IsDone = false, Rewards = Rewards["TV"] },
            }
        },
    }
}
