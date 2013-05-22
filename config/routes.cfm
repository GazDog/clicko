<cfscript>
drawRoutes()
	
	// master admin
    .namespace("master")
    	// Administrators
        .controller("Administrators")
            .get("new")
            .post("create")
            .get(name="show", pattern="show/[key]")
            .get(name="edit", pattern="edit/[key]")
            .post(name="update", pattern="update/[key]")
            .get(name="delete", pattern="delete/[key]")
            .root(action="index")
        .end()
         // Agencies
        .controller("Agencies")
            .get("new")
            .post("create")
            .get(name="show", pattern="show/[key]")
            .get(name="edit", pattern="edit/[key]")
            .post(name="update", pattern="update/[key]")
            .get(name="delete", pattern="delete/[key]")
            .root(action="index")
        .end()
        // Dashboard
        .controller("Dash")
            .root(action="index")
        .end()
    .end()

    // administration side
    .namespace("admin")
		// Ajax
    	.controller("ajax")
            .get("search")
        .end()
        // Customers
        .controller("Customers")
            .get("new")
            .post("create")
            .get(name="show", pattern="show/[key]")
            .get(name="edit", pattern="edit/[key]")
            .post(name="update", pattern="update/[key]")
            .get(name="delete", pattern="delete/[key]")
            .root(action="index")
        .end()
        // Assets
        .controller("Assets")
            .get("new")
            .post("create")
            .get(name="show", pattern="show/[key]")
            .get(name="edit", pattern="edit/[key]")
            .post(name="update", pattern="update/[key]")
            .get(name="delete", pattern="delete/[key]")
            .root(action="index")
        .end()
        // Campaigns
        .controller("Campaigns")
            .get("new")
            .post("create")
            .get(name="show", pattern="show/[key]")
            .get(name="edit", pattern="edit/[key]")
            .post(name="update", pattern="update/[key]")
            .get(name="delete", pattern="delete/[key]")
            .root(action="index")
        .end()
        // Publishers
        .controller("Publishers")
            .get("new")
            .post("create")
            .get(name="show", pattern="show/[key]")
            .get(name="edit", pattern="edit/[key]")
            .post(name="update", pattern="update/[key]")
            .get(name="delete", pattern="delete/[key]")
            .root(action="index")
        .end()
        // Users
        .controller("Users")
            .get("new")
            .post("create")
            .get(name="show", pattern="show/[key]")
            .get(name="edit", pattern="edit/[key]")
            .post(name="update", pattern="update/[key]")
            .get(name="delete", pattern="delete/[key]")
            .root(action="index")
        .end()
        // Dashboard
        .controller("Dash")
            .root(action="index")
        .end()
        // Clicks
        .controller("Clicks")
            .root(action="index")
        .end()
    .end()

	// login
	.get(name="logout", pattern="/logOut", controller="login", action="delete")
	.get(name="admin", pattern="/admin", controller="login", action="new")

	// engine
	.get(name="engineShort", pattern="/l/[key]", controller="engine", action="index")
    .get(name="engineSlug", pattern="/l/[key]/[slug]", controller="engine", action="index")

    // restful style customer entities
    // index
    .get(name="customerPublishersIndex", pattern="customers/[customerId]/publishers", to="admin.publishers##index")
    .get(name="customerCampaignsIndex", pattern="customers/[customerId]/campaigns", to="admin.campaigns##index")
    .get(name="customerAssetsIndex", pattern="customers/[customerId]/assets", to="admin.assets##index")
    // show
    .get(name="customerPublishersShow", pattern="customers/[customerId]/publishers/show/[key]", to="admin.publishers##show")
    .get(name="customerCampaignsShow", pattern="customers/[customerId]/campaigns/show/[key]", to="admin.campaigns##show")
    .get(name="customerAssetsShow", pattern="customers/[customerId]/assets/show/[key]", to="admin.assets##show")
    // new    
    .get(name="customerPublishersNew", pattern="customers/[customerId]/publishers/new", to="admin.publishers##new")
    .get(name="customerCampaignsNew", pattern="customers/[customerId]/campaigns/new", to="admin.campaigns##new")
    .get(name="customerAssetsNew", pattern="customers/[customerId]/assets/new", to="admin.assets##new")
    // edit
    .get(name="customerPublishersEdit", pattern="customers/[customerId]/publishers/edit/[key]", to="admin.publishers##edit")
    .get(name="customerCampaignsEdit", pattern="customers/[customerId]/campaigns/edit/[key]", to="admin.campaigns##edit")
    .get(name="customerAssetsEdit", pattern="customers/[customerId]/assets/edit/[key]", to="admin.assets##edit")
    // create 
    .get(name="customerPublishersCreate", pattern="customers/[customerId]/publishers/create", to="admin.publishers##create")
    .get(name="customerCampaignsCreate", pattern="customers/[customerId]/campaigns/create", to="admin.campaigns##create")
    .get(name="customerAssetsCreate", pattern="customers/[customerId]/assets/create", to="admin.assets##create")
    // update
    .get(name="customerPublishersUpdate", pattern="customers/[customerId]/publishers/update/[key]", to="admin.publishers##update")
    .get(name="customerCampaignsUpdate", pattern="customers/[customerId]/campaigns/update/[key]", to="admin.campaigns##update")
    .get(name="customerAssetsUpdate", pattern="customers/[customerId]/assets/update/[key]", to="admin.assets##update")
    // delete
    .get(name="customerPublishersDelete", pattern="customers/[customerId]/publishers/delete/[key]", to="admin.publishers##delete")
    .get(name="customerCampaignsDelete", pattern="customers/[customerId]/campaigns/delete/[key]", to="admin.campaigns##delete")
    .get(name="customerAssetsDelete", pattern="customers/[customerId]/assets/delete/[key]", to="admin.assets##delete")
    
    // default routes
    .wildcard()
    .root(to="pages##index")
.end();
</cfscript>