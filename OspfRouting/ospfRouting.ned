package inet.examples.OspfRouting;

import inet.common.scenario.ScenarioManager;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ospfv2.OspfRouter;
import inet.node.ospfv2.OspfRouter;
import inet.node.inet.StandardHost;
import inet.node.ethernet.EthernetSwitch;
import inet.networklayer.ted.LinkStateRouting;
import inet.networklayer.ipv4.Ipv4RoutingTable;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.visualizer.common.IntegratedVisualizer;
import inet.common.misc.ThruputMeteringChannel;
package inet.examples.OspfRouting;

network OspfRouting
{
    @display("bgb=831,570");
    types:

        channel LINK_100 extends ThruputMeteringChannel
        {
            parameters:
                delay = 0.1us;
                datarate = 100Mbps;
                thruputDisplayFormat = "#N";
        }
    submodules:
        H1: StandardHost {
            //  @networkNode;
            @display("p=101.023994,331.772");
            gates:
                ethg[1];
        }
        H2: StandardHost {
            //  @networkNode;
            @display("p=714.05597,327.18");
            gates:
                ethg[1];
        }
        SW1: EthernetSwitch {
            @display("p=101.023994,210.084");
        }
        SW2: EthernetSwitch {
            @display("p=714.05597,212.37999");
        }
        R1: OspfRouter {
            parameters:
            	@display("p=269.78,213.528");
            	hasStatus = true;
            gates:
                ethg[3];
        }
        R2: OspfRouter {
            parameters:
                @display("p=388.024,103.32");
                hasStatus = true;
            gates:
                ethg[2];
        }
        R3: OspfRouter {
            parameters:
                @display("p=510.86,213.528");
                hasStatus = true;
            gates:
                ethg[3];
        }
        R4: OspfRouter {
            parameters:
            	@display("p=388.024,327.18");
            	hasStatus = true;
            gates:
                ethg[2];
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=714.05597,71.175995");
        }
        integratedVisualizer: IntegratedVisualizer {
            @display("p=101.023994,467.236");
        }
        scenarioManager: ScenarioManager {
            @display("p=101.023994,70.028");
        }
    connections:
        R1.ethg[0] <--> LINK_100 <--> R4.ethg[0];
        R1.ethg[1] <--> LINK_100 <--> R2.ethg[1];
        R2.ethg[0] <--> LINK_100 <--> R3.ethg[0];
        R3.ethg[1] <--> LINK_100 <--> R4.ethg[1];

        R1.ethg[2] <--> LINK_100 <--> SW1.ethg++;
        R3.ethg[2] <--> LINK_100 <--> SW2.ethg++;
        SW1.ethg++ <--> LINK_100 <--> H1.ethg[0];
        SW2.ethg++ <--> LINK_100 <--> H2.ethg[0];
}
