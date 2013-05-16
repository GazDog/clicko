component
	extends="clicko.controllers.Controller"
	hint="Base admin controller."
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		super.init();
		filters(through="isAuthenticated");
	}

}