QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
if QBShared.QBJobsStatus then return end
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
	['police'] = {
		label = 'Polisi',
        type = 'leo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Seba',
                payment = 50
            },
			[1] = {
                name = 'Tamtama',
                payment = 75
            },
			[2] = {
                name = 'Bripda',
                payment = 100
            },
			[3] = {
                name = 'Briptu',
                payment = 125
            },
			[4] = {
                name = 'Brigpol',
                payment = 150
            },
            [5] = {
                name = 'Bripka',
                payment = 175
            },
            [6] = {
                name = 'Aipda',
                payment = 200
            },
            [7] = {
                name = 'Aiptu',
                payment = 225
            },
            [8] = {
                name = 'Ipda',
                payment = 250
            },
            [9] = {
                name = 'Iptu',
                payment = 275
            },
            [10] = {
                name = 'Akp',
                payment = 300
            },
            [11] = {
                name = 'Kompol',
                payment = 325
            },
            [12] = {
                name = 'Akbp',
                payment = 350
            },
            [13] = {
                name = 'Kombes',
                payment = 375
            },
            [14] = {
                name = 'Sekjen',
                isboss = true,
                payment = 400
            },
            [15] = {
                name = 'Brigjen',
                isboss = true,
                payment = 550
            },
            [16] = {
                name = 'Irjen',
				isboss = true,
                payment = 650
            },
            [17] = {
                name = 'Komjen',
				isboss = true,
                payment = 750
            },
            [18] = {
                name = 'Jendral',
				isboss = true,
                payment = 850
            },
            [19] = {
                name = 'Jendral Besar',
				isboss = true,
                payment = 950
            },
        },
	},
	['bcso'] = {
		label = 'BCSO',
        type = 'leo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Officer',
                payment = 75
            },
			[2] = {
                name = 'Sergeant',
                payment = 100
            },
			[3] = {
                name = 'Lieutenant',
                payment = 125
            },
			[4] = {
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
	},
	['sasp'] = {
		label = 'SASP',
        type = 'leo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Officer',
                payment = 75
            },
			[2] = {
                name = 'Sergeant',
                payment = 100
            },
			[3] = {
                name = 'Lieutenant',
                payment = 125
            },
			[4] = {
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Paramedic',
                payment = 75
            },
			[2] = {
                name = 'Doctor',
                payment = 100
            },
			[3] = {
                name = 'Surgeon',
                payment = 125
            },
			[4] = {
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'House Sales',
                payment = 75
            },
			[2] = {
                name = 'Business Sales',
                payment = 100
            },
			[3] = {
                name = 'Broker',
                payment = 125
            },
			[4] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Driver',
                payment = 75
            },
			[2] = {
                name = 'Event Driver',
                payment = 100
            },
			[3] = {
                name = 'Sales',
                payment = 125
            },
			[4] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
    ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Showroom Sales',
                payment = 75
            },
			[2] = {
                name = 'Business Sales',
                payment = 100
            },
			[3] = {
                name = 'Finance',
                payment = 125
            },
			[4] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
        type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Novice',
                payment = 75
            },
			[2] = {
                name = 'Experienced',
                payment = 100
            },
			[3] = {
                name = 'Advanced',
                payment = 125
            },
			[4] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
}
