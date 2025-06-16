"Ride Class (Base Class)"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance fare |

    Ride class >> newRideID: anID pickupLocation: pickup dropoffLocation: dropoff distance: aDistance [
        ^self new initializeWithID: anID pickupLocation: pickup dropoffLocation: dropoff distance: aDistance.
    ]

    Ride >> initializeWithID: anID pickupLocation: pickup dropoffLocation: dropoff distance: aDistance [
        rideID := anID.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := aDistance.
        fare := 0.0.
    ]

    Ride >> fare [
        fare := distance * 1.5. "Standard fare calculation"
        ^fare.
    ]

    Ride >> rideDetails [
        ^'Ride ID: ', rideID printString, ', Pickup Location: ', pickupLocation, ', Dropoff Location: ', dropoffLocation.
    ]
]

"StandardRide Subclass"
Ride subclass: StandardRide [
    StandardRide >> fare [
        fare := distance * 1.5. "Standard ride fare"
        ^fare.
    ]
]

"PremiumRide Subclass"
Ride subclass: PremiumRide [
    PremiumRide >> fare [
        fare := distance * 2.0. "Premium ride fare (higher per mile)"
        ^fare.
    ]
]

"Driver Class"
Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> newDriverID: anID name: aName rating: aRating [
        ^self new initializeWithID: anID name: aName rating: aRating.
    ]

    Driver >> initializeWithID: anID name: aName rating: aRating [
        driverID := anID.
        name := aName.
        rating := aRating.
        assignedRides := OrderedCollection new.
    ]

    Driver >> addRide: aRide [
        assignedRides add: aRide.
    ]

    Driver >> getDriverInfo [
        ^'Driver: ', name, ', Rating: ', rating printString.
    ]
]

"Rider Class"
Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> newRiderID: anID name: aName [
        ^self new initializeWithID: anID name: aName.
    ]

    Rider >> initializeWithID: anID name: aName [
        riderID := anID.
        name := aName.
        requestedRides := OrderedCollection new.
    ]

    Rider >> requestRide: aRide [
        requestedRides add: aRide.
    ]

    Rider >> viewRides [
        requestedRides do: [:ride |
            FileStream stdout nextLine; nextPutAll: ride rideDetails; flush.
        ].
    ]
]

"Main"
| ride1 ride2 driver rider |
ride1 := StandardRide newRideID: 1 pickupLocation: 'A' dropoffLocation: 'B' distance: 10.
ride2 := PremiumRide newRideID: 2 pickupLocation: 'C' dropoffLocation: 'D' distance: 15.
driver := Driver newDriverID: 101 name: 'John Doe' rating: 4.
rider := Rider newRiderID: 202 name: 'Alice Smith'.

driver addRide: ride1.
driver addRide: ride2.

rider requestRide: ride1.
rider requestRide: ride2.

rider viewRides.
"Expected Output"
"Ride ID: 1, Pickup Location: A, Dropoff Location: B"
"Ride ID: 2, Pickup Location: C, Dropoff Location: D"
