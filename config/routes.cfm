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

    // default routes
    .wildcard()
    .root(to="pages##index")
.end();
</cfscript>