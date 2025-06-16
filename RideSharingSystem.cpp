#include <iostream>
#include <vector>
#include <string>

using namespace std;

// Base Ride Class
class Ride {
protected:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;
    double fare;

public:
    Ride(int id, string pickup, string dropoff, double dist) {
        rideID = id;
        pickupLocation = pickup;
        dropoffLocation = dropoff;
        distance = dist;
        fare = 0.0;
    }

    virtual double fareCalculation() {
        fare = distance * 1.5;  // Standard fare
        return fare;
    }

    virtual void rideDetails() {
        cout << "Ride ID: " << rideID << ", Pickup Location: " << pickupLocation << ", Dropoff Location: " << dropoffLocation << endl;
    }

    virtual ~Ride() {}
};

// Derived StandardRide Class
class StandardRide : public Ride {
public:
    StandardRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}

    double fareCalculation() override {
        fare = distance * 1.5;  // Standard fare
        return fare;
    }
};

// Derived PremiumRide Class
class PremiumRide : public Ride {
public:
    PremiumRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}

    double fareCalculation() override {
        fare = distance * 2.0;  // Premium fare (higher per mile)
        return fare;
    }
};

// Driver Class
class Driver {
private:
    int driverID;
    string name;
    double rating;
    vector<Ride*> assignedRides;

public:
    Driver(int id, string driverName, double driverRating) {
        driverID = id;
        name = driverName;
        rating = driverRating;
    }

    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() {
        cout << "Driver: " << name << ", Rating: " << rating << endl;
    }
};

// Rider Class
class Rider {
private:
    int riderID;
    string name;
    vector<Ride*> requestedRides;

public:
    Rider(int id, string riderName) {
        riderID = id;
        name = riderName;
    }

    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() {
        for (Ride* ride : requestedRides) {
            ride->rideDetails();
        }
    }
};

// Main Function
int main() {
    StandardRide ride1(1, "A", "B", 10);
    PremiumRide ride2(2, "C", "D", 15);

    Driver driver(101, "John Doe", 4.5);
    Rider rider(202, "Alice Smith");

    driver.addRide(&ride1);
    driver.addRide(&ride2);

    rider.requestRide(&ride1);
    rider.requestRide(&ride2);

    rider.viewRides();

    return 0;
}
