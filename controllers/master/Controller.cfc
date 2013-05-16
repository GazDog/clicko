component
	extends="clicko.controllers.Controller"
	hint="Base master controller."
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		super.init();
		filters(through="isAuthenticated,isAdministrator");
	}

	// --------------------------------------------------
	// Filters

	/*
	 * @hint Ensures user is an admin.
	 */
	private void function isAdministrator() {
		if ( ! currentUser.isAdministrator ) {
			redirectTo(route="home", message="Unathorized!", messageType="error");	
		}
	}
}