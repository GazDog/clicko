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
    .end()

    // administration side
    .namespace("admin")
		// Ajax
    	.controller("ajax")
            .get("search")
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
    .end()

	// login
	.get(name="logOut", pattern="/logOut", controller="login", action="delete")
	.get(name="admin", pattern="/admin", controller="login", action="new")

	// engine
	.get(name="engine", pattern="/l/[key]", controller="engine", action="index")

    // default routes
    .wildcard()
    .root(to="pages##index")
.end();
</cfscript>