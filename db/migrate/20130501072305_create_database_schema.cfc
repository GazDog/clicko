<!---
    |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
    |----------------------------------------------------------------------------------------------|
	| name       | Yes      | string  |         | table name, in pluralized form                   |
	| force      | No       | boolean | false   | drop existing table of same name before creating |
	| id         | No       | boolean | true    | if false, defines a table with no primary key    |
	| primaryKey | No       | string  | id      | overrides default primary key name
    |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      t = createTable(name='employees',force=false,id=true,primaryKey='empId');
      t.string(columnNames='name', default='', null=true, limit='255');
      t.text(columnNames='bio', default='', null=true);
      t.time(columnNames='lunchStarts', default='', null=true);
      t.datetime(columnNames='employmentStarted', default='', null=true);
      t.integer(columnNames='age', default='', null=true, limit='1');
      t.decimal(columnNames='hourlyWage', default='', null=true, precision='1', scale='2');
      t.date(columnNames='dateOfBirth', default='', null=true);
--->
<cfcomponent extends="plugins.dbmigrate.Migration" hint="create database schema">
  <cffunction name="up">
    <cfscript>
      /* USERS */
      t = createTable(name='users', id=true);
      t.integer(columnNames="agencyid", null=true);
      // t.references("agencies");
      t.boolean(columnNames='isadministrator', default=false, null=false);
      t.string(columnNames="firstname,lastname", null=false, limit=64);
      t.string(columnNames="phone", null=false, limit=64);
      t.string(columnNames="email", null=false, limit=64);
      t.integer(columnNames="accesslevel", null=false, default=1);
      t.integer(columnNames="statusid", null=false, default=1);
      t.string(columnNames="password,salt", null=false, limit=256);
      t.string(columnNames="passwordresettoken", null=true, limit=256);
      t.datetime(columnNames="passwordresetat", null=true);
      t.boolean(columnNames='isconfirmed', default=false, null=false);
      t.string(columnNames="emailconfirmationtoken", null=true, limit=256);
      t.datetime(columnNames="lastloginat", null=true);
      t.integer(columnNames="logincount", null=false, default=0);
      t.timestamps();
      t.create();

      /* AGENCIES */
      t = createTable(name='agencies', id=true);
      t.string(columnNames="name", null=false, limit=64);
      t.string(columnNames="streetnumber", null=true, limit=16);
      t.string(columnNames="streetname", null=true, limit=64);
      t.string(columnNames="suburb", null=true, limit=32);
      t.string(columnNames="phone", null=true, limit=16);
      t.string(columnNames="email", null=true, limit=64);
      t.integer(columnNames="statusid", null=false, default=1);
      t.integer(columnNames="accesslevel", null=false, default=1);
      t.timestamps();
      t.create();

      /* CUSTOMERS */
      t = createTable(name='customers', id=true);
      t.integer(columnNames="agencyid", null=false);
      // t.references("agencies");
      t.string(columnNames="name", null=false, limit=64);
      t.string(columnNames="website", null=false, limit=64);
      t.string(columnNames="phone", null=true, limit=16);
      t.string(columnNames="email", null=true, limit=64);
      t.integer(columnNames="statusid", null=false, default=1);
      t.integer(columnNames="accesslevel", null=false, default=1);
      t.timestamps();
      t.create();

      /* PUBLISHERS */
      t = createTable(name='publishers', id=true);
      t.integer(columnNames="customerid", null=false);
      // t.references("customers");
      t.string(columnNames="name", null=false, limit=64);
      t.string(columnNames="website", null=false, limit=64);
      t.string(columnNames="contactname", null=false, limit=64);
      t.string(columnNames="phone", null=true, limit=16);
      t.string(columnNames="email", null=true, limit=64);
      t.integer(columnNames="statusid", null=false, default=1);
      t.timestamps();
      t.create();

      /* CAMPAIGNS */
      t = createTable(name='campaigns', id=true);
      t.integer(columnNames="customerid", null=false);
      // t.references("customers");
      t.string(columnNames="name", null=false, limit=64);
      t.datetime(columnNames="startat,finishat", null=true);
      t.integer(columnNames="creatoruserid", null=false);
      t.timestamps();
      t.create();

      /* ASSETS */
      t = createTable(name='assets', id=true);
      t.integer(columnNames="campaignid", null=false);
      t.integer(columnNames="publisherid", null=false);
      // t.references("campaigns,publishers");
      t.string(columnNames="name", null=false, limit=64);
      t.string(columnNames="destinationurl", null=false, limit=128);
      t.datetime(columnNames="startat,finishat", null=true);
      t.text(columnNames="notes", null=true);
      t.timestamps();
      t.create();

      /* CLICKS */
      t = createTable(name='clicks', id=true);
      // t.references("assets");
      t.integer(columnNames="assetid", null=false);
      t.string(columnNames="ipaddress", null=false, limit=32);
      t.string(columnNames="browser", null=false, limit=32);
      t.datetime(columnNames="createdat", null=true);
      t.create();

      /* ACTIONS */
      t = createTable(name='actions', id=true);
      t.string(columnNames="entitytype", null=false, limit=16);
      t.integer(columnNames="entityid", null=false);
      // t.references("users");
      t.datetime(columnNames="createdat", null=true);
      t.create();

      /* CHANGES */    
      t = createTable(name='changes', id=true);
      t.integer(columnNames="actionid", null=false);
      // t.references("actions");
      t.string(columnNames="oldvalue,newvalue", null=false, limit=64);
      t.create();

    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
      dropTable('tableName');
    </cfscript>
  </cffunction>
</cfcomponent>