import com.thoughtworks.microbuilder.tutorial.githubSdk.model.*;
import com.thoughtworks.microbuilder.tutorial.githubSdk.proxy.*;
import com.thoughtworks.microbuilder.core.*;

class Main {
	
	public static function main() {
		// Initialize organization service in Github SDK
		var organizationService = {
			var urlPrefix = "https://api.github.com/";
			var routeConfiguration = MicrobuilderRouteConfigurationFactory.routeConfiguration_com_thoughtworks_microbuilder_tutorial_githubSdk_rpc_IOrganizationService();
			var outgoingJsonService = new MicrobuilderOutgoingJsonService(urlPrefix, routeConfiguration);
			MicrobuilderOutgoingProxyFactory.outgoingProxy_com_thoughtworks_microbuilder_tutorial_githubSdk_rpc_IOrganizationService(outgoingJsonService);
		}

		// Read the GITHUB_USERNAME environment variables
		var username = Sys.environment()["GITHUB_USERNAME"];

		// Send a request to Github API via organization service
		organizationService.listUserOrganizations(username).start(
			function(response):Void {
				trace('$username belong to ${response.length} organizations: ${ [ for (organization in response) "\n * " + organization.login ].join("") }');
			},
			function(error):Void {
				trace('Error: $error');
			}
		);
	}
}
