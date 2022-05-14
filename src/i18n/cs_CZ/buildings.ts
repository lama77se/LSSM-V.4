import type { InternalBuilding } from '../../../typings/Building';

type Extension = InternalBuilding['extensions'][0];

const multiplyExtension = (
    extension: Extension | ((index: number) => Extension),
    amount: number
): Extension[] =>
    typeof extension === 'function'
        ? new Array(amount).fill('0').map((_, index) => extension(index))
        : new Array(amount).fill(extension);

export default {
    0: {
        caption: 'Požární stanice',
        color: '#bb0000',
        coins: 30,
        credits: 100_000,
        extensions: [
            {
                caption: 'Rozšíření záchranné služby',
                credits: 100_000,
                coins: 20,
                duration: '7 dní',
            },
            {
                caption: 'Rozšíření vyprošťovacích prací',
                credits: 125_000,
                coins: 25,
                duration: '3 dny',
            },
            {
                caption: 'Rozšíření vodní záchranné služby',
                credits: 50_000,
                coins: 10,
                duration: '3 dny',
            },
        ],
        levelcost: ['1. 10.000', '2. 50.000', '3.-39. 100.000'],
        maxBuildings: '6.000 together with small fire stations',
        maxLevel: 24,
        special:
            'From the 24th fire station onwards, the cost of building a new fire station increases according to the following formula: <code>100.000+200.000*LOG<sub>2</sub>(Number of existing fire stations − 22)</code>. The Coins price remains constant!',
        startPersonnel: 10,
        startVehicles: ['CAS 20', 'CAS 30'],
        startParkingLots: 1,
        schoolingTypes: ['Školní a výcvikové zařízení HZS'],
        maxBuildingsFunction: (): number => 6000,
    },
    1: {
        caption: 'Školní a výcvikové zařízení HZS',
        color: '#992222',
        coins: 50,
        credits: 500_000,
        extensions: multiplyExtension(
            {
                caption: 'Additional classroom',
                credits: 400_000,
                coins: 40,
                duration: '7 dní',
                newClassrooms: 1,
            },
            3
        ),
        levelcost: [],
        maxBuildings: 'No limit',
        maxLevel: 0,
        startClassrooms: 1,
        special:
            "Finance ministers and admins can (expand) fire department schools with the help of credits from the association's treasury.Training course masters and admins can start training courses at association fire- brigade schools.",
    },
    2: {
        caption: 'Výjezdové stanoviště ZZS',
        color: '#ffa500',
        coins: 35,
        credits: 200_000,
        extensions: [],
        levelcost: ['1. 10.000', '2. 50.000', '3.-39. 100.000'],
        maxBuildings: 'No limit',
        maxLevel: 14,
        special: '',
        startPersonnel: 3,
        startParkingLots: 1,
        startVehicles: ['RZP'],
        schoolingTypes: ['Zdravotnická akademie'],
    },
    3: {
        caption: 'Zdravotnická akademie',
        color: '#992222',
        coins: 50,
        credits: 500_000,
        extensions: multiplyExtension(
            {
                caption: 'Additional classroom',
                credits: 400_000,
                coins: 40,
                duration: '7 dní',
                newClassrooms: 1,
            },
            3
        ),
        levelcost: [],
        maxBuildings: 'No limit',
        maxLevel: 0,
        startClassrooms: 1,
        special:
            "Finance ministers and admins can (expand) fire department schools with the help of credits from the association's treasury.Training course masters and admins can start training courses at association fire- brigade schools.",
    },
    4: {
        caption: 'Nemocnice',
        color: '#bbe944',
        coins: 25,
        credits: 200_000,
        extensions: [
            {
                caption: 'Všeobecný internista',
                credits: 10_000,
                coins: 10,
                duration: '7 dní',
            },
            {
                caption: 'Všeobecný chirurg',
                credits: 10_000,
                coins: 10,
                duration: '7 dní',
            },
            {
                caption: 'Gynekologie',
                credits: 70_000,
                coins: 15,
                duration: '7 dní',
            },
            {
                caption: 'Urologie',
                credits: 70_000,
                coins: 15,
                duration: '7 dní',
            },
            {
                caption: 'Úrazová chirurgie',
                credits: 70_000,
                coins: 15,
                duration: '7 dní',
            },
            {
                caption: 'Neurologie',
                credits: 70_000,
                coins: 15,
                duration: '7 dní',
            },
            {
                caption: 'Neurochirurgie',
                credits: 70_000,
                coins: 15,
                duration: '7 dní',
            },
            {
                caption: 'Kardiologie',
                credits: 70_000,
                coins: 15,
                duration: '7 dní',
            },
            {
                caption: 'Kardiochirurgie',
                credits: 70_000,
                coins: 15,
                duration: '7 dní',
            },
        ],
        levelcost: ['1.-20. 19.000 Credits / 11 Coins'],
        maxBuildings: 'No limit',
        maxLevel: 20,
        startBeds: 10,
        special:
            'Finance ministers and admins can (expand) association hospitals with the help of credits from the association treasury.',
    },
    5: {
        caption: 'Základna Letecké záchranné služby',
        color: '#e7ad2f',
        coins: 50,
        credits: 1_000_000,
        extensions: [],
        levelcost: [],
        maxBuildings: 'see specials',
        maxLevel: 0,
        special:
            'Up to the 125th building (of all types) a total of max. 4 landing sites can be built. After that the number increases by 1 every 25 buildings (starting at the 125th).',
        startPersonnel: 0,
        startVehicles: [],
        startParkingLots: 1,
        maxBuildingsFunction: (buildingsAmountTotal: number): number =>
            buildingsAmountTotal < 125
                ? 4
                : Math.floor(buildingsAmountTotal / 25),
        schoolingTypes: ['Zdravotnická akademie'],
    },
    6: {
        caption: 'Obvodní oddělení Policie',
        color: '#007700',
        coins: 35,
        credits: 100_000,
        extensions: [
            ...multiplyExtension(
                {
                    caption: 'Vězeňská cela',
                    credits: 25_000,
                    coins: 5,
                    duration: '7 dní',
                    newCells: 1,
                },
                10
            ),
        ],
        levelcost: ['1. 10.000', '2. 50.000', '3.-39. 100.000'],
        maxBuildings: '1.700 together with small police stations',
        maxLevel: 39,
        special:
            'From the 24th police station onwards, the costs for the new construction of a police station increase according to the following formula: <code>100.000+200.000*LOG<sub>2</sub>(Number of existing police stations − 22)</code>. The Coins price remains constant!',
        startPersonnel: 2,
        startParkingLots: 1,
        startCells: 0,
        startVehicles: ['Policejní automobil'],
        maxBuildingsFunction: (): number => 1700,
        schoolingTypes: ['Policejní Akademie'],
    },
    7: {
        caption: 'Operační středisko',
        color: '#24c3ae',
        coins: 0,
        credits: 0,
        extensions: [],
        levelcost: [],
        maxBuildings: 'All 25 buildings one control center',
        maxLevel: 0,
        special: 'The control center is the administrative center.',
        maxBuildingsFunction: (buildingsAmountTotal: number): number =>
            Math.floor(buildingsAmountTotal / 25) + 1,
        isDispatchCenter: true,
    },
    8: {
        caption: 'Policejní Akademie',
        color: '#225522',
        coins: 50,
        credits: 500_000,
        extensions: multiplyExtension(
            {
                caption: 'Additional classroom',
                credits: 400_000,
                coins: 40,
                duration: '7 dní',
                newClassrooms: 1,
            },
            3
        ),
        levelcost: [],
        maxBuildings: 'No limit',
        maxLevel: 0,
        startClassrooms: 1,
        special:
            "Finance ministers and admins can (expand) association police schools with the help of credits from the association's treasury.Training course masters and admins can start training courses at association police schools.",
    },
    13: {
        caption: 'Základna Letecké služby PČR',
        color: '#148423',
        coins: 50,
        credits: 1_000_000,
        extensions: [],
        levelcost: ['1. 1.000.000 Credits / 50 Coins'],
        maxBuildings: 'see specials',
        maxLevel: 1,
        special:
            'Up to 2 landing sites can be built per station (expansion stages). Up to the 125th building (of all types) a total of max. 4 landing sites can be built. After that the number increases by 1 every 25 buildings (starting at the 125th).',
        startPersonnel: 3,
        startVehicles: [],
        startParkingLots: 1,
        maxBuildingsFunction: (buildingsAmountTotal: number): number =>
            buildingsAmountTotal < 125
                ? 4
                : Math.floor(buildingsAmountTotal / 25),
        schoolingTypes: ['Policejní Akademies'],
    },
    14: {
        caption: 'Přípravná oblast',
        color: '#c259b5',
        coins: 0,
        credits: 0,
        extensions: [],
        levelcost: [],
        maxBuildings: 4,
        maxLevel: 0,
        special:
            'You can station as many of your own vehicles as you like at a staging area, members of the association can use the room. A staging area remains for 24 hours, but you can reset it to 24 hours at any time.With Premium Account you can have 8 stating areas at the same time',
        maxBuildingsFunction: (): number => 4,
        isStagingArea: true,
    },
    15: {
        caption: 'Vodní záchranná služba ČČK',
        color: '#ffa500',
        coins: 35,
        credits: 200_000,
        extensions: [],
        levelcost: ['1. 10.000', '2. 50.000', '3.-39. 100.000'],
        maxBuildings: 'No limit',
        maxLevel: 39,
        special: '',
        startPersonnel: 3,
        startVehicles: [],
        startParkingLots: 1,
        schoolingTypes: ['Školící středisko VZS ČČK'],
    },
    16: {
        caption: 'Prison Cells',
        color: '#00ff00',
        coins: -1,
        credits: 100_000,
        extensions: multiplyExtension(
            {
                caption: 'Prison Cell',
                credits: 25_000,
                coins: 5,
                duration: '7 dní',
                newCells: 1,
            },
            10
        ),
        levelcost: [],
        maxBuildings: 'No limit',
        maxLevel: 0,
        special:
            "This building can only be built and developed by admins and finance ministers with credits from the association's treasury.The built Prison Cells are available to all members of the association.",
        startCells: 1,
    },
    18: {
        caption: 'Požární stanice (malá)',
        color: '#aa1111',
        coins: 25,
        credits: 50_000,
        extensions: [],
        levelcost: [
            '1. 10.000',
            '2. 50.000',
            '3.-5. 100.000',
            'Conversion to normal station: difference price to normal station',
        ],
        maxBuildings: '6.000 together with fire stations',
        maxLevel: 5,
        special:
            'From the 24th fire station onwards, the cost of building a new fire station increases according to the following formula: <code>(100.000+200.000*LOG<sub>2</sub>(Number of existing fire stations − 22)) / 2</code>. max. 1 Million Credits. The Coins price remains constant!',
        startPersonnel: 10,
        startVehicles: ['CAS 20', 'CAS 30'],
        startParkingLots: 1,
        maxBuildingsFunction: (): number => 6000,
        schoolingTypes: ['Školní a výcvikové zařízení HZS'],
    },
    19: {
        caption: 'Obvodní oddělení Policie (malé)',
        color: '#116611',
        coins: 25,
        credits: 50_000,
        extensions: [],
        levelcost: [
            '1. 10.000',
            '2. 50.000',
            '3.-4. 100.000',
            'Conversion to normal station: difference price to normal station',
        ],
        maxBuildings: '1.700 with police stations together',
        maxLevel: 4,
        special:
            'From the 24th police station onwards, the costs for the new construction of a police station are calculated according to the following formula: <code>(100.000+200.000*LOG<sub>2</sub>(Number of existing police stations − 22)) / 2</code>. The Coins price remains constant!',
        startPersonnel: 2,
        startVehicles: ['Policejní automobil'],
        startParkingLots: 1,
        maxBuildingsFunction: (): number => 1700,
        schoolingTypes: ['Policejní Akademie'],
    },
    20: {
        caption: 'Výjezdové stanoviště ZZS (malá)',
        color: '#eeb611',
        coins: 25,
        credits: 100_000,
        extensions: [],
        levelcost: [
            '1. 10.000',
            '2. 50.000',
            '3.-5. 100.000',
            'Conversion to normal station: difference price to normal station',
        ],
        maxBuildings: 'No limit',
        maxLevel: 5,
        special: '',
        startPersonnel: 3,
        startParkingLots: 1,
        startVehicles: ['RZP'],
        schoolingTypes: ['Zdravotnická akademie'],
    },
    21: {
        caption: 'Pyrotechnická služba PČR',
        color: '#663300',
        coins: 50,
        credits: 5_000_000,
        extensions: [],
        levelcost: ['1. 10.000', '2. 50.000', '3.-20. 100.000'],
        maxBuildings: 'No limit',
        maxLevel: 5,
        special: '',
        startPersonnel: 4,
        startVehicles: ['Vozidlo pyrotechnika PČR'],
        startParkingLots: 2,
        schoolingTypes: ['Policejní Akademie'],
    },
    22: {
        caption: 'Školící středisko VZS ČČK',
        color: '#225522',
        coins: 50,
        credits: 500_000,
        extensions: multiplyExtension(
            {
                caption: 'Additional classroom',
                credits: 400_000,
                coins: 40,
                duration: '7 dní',
                newClassrooms: 1,
            },
            3
        ),
        levelcost: [],
        maxBuildings: 'No limit',
        maxLevel: 0,
        special:
            "Finance ministers and admins can (expand) association police schools with the help of credits from the association's treasury.Training course masters and admins can start training courses at association police schools.",
        startClassrooms: 1,
    },
} as Record<number, InternalBuilding>;
