#include <iostream>
#include <fstream>
#include <string>
#include <IPv4RoutingTable.h>
#include <omnetpp.h>
using namespace std;
using namespace ospfR;

// module class declaration
class IP4RoutingTable : public cSimpleModule
{
  protected:
    // state variables
    // ...
    virtual void processMsgFromHigherLayer(cMessage *packet);
    virtual void processMsgFromLowerLayer(FooPacket *packet);
    virtual void processTimer(cMessage *timer);
  public:
    virtual void handleMessage(cMessage *msg) override;
    virtual void initialize() override;

};

// module type registration
Define_Module(IP4RoutingTable);


// Implementation of the module class
void IP4RoutingTable::handleMessage(cMessage *msg)
{
    if (msg->isSelfMessage())
        processTimer(msg);
    else if (msg->arrivedOn("fromNetw"))
        processMsgFromLowerLayer(check_and_cast<FooPacket *>(msg));
    else
        processMsgFromHigherLayer(msg);
}
void IP4RoutingTable::initialize()
{
  IPv4RoutingTable:: printRoutingTable () ;
}
