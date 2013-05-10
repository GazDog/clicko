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
      t.integer(columnName="agencyid", null=true);
      t.boolean(columnName='isadministrator', default=false, null=false);
      t.string(columnName="firstname,lastname,phone,email", null=false, limit=50);
      t.integer(columnName="accesslevel", null=false, default=1);
      t.integer(columnName="statusid", null=false, default=1);
      t.string(columnName="password,salt", null=false, limit=255);
      t.string(columnName="passwordresettoken", null=true, limit=255);
      t.datetime(columnName="passwordresetat", null=true);
      t.boolean(columnName='isconfirmed', default=false, null=false);
      t.string(columnName="emailconfirmationtoken", null=true, limit=255);
      t.datetime(columnName="lastloginat", null=true);
      t.integer(columnName="logincount", null=false, default=0);
      t.timestamps();
      t.create();

      /* AGENCIES */
      t = createTable(name='agencies', id=true);
      t.string(columnName="name", null=false, limit=50);
      t.string(columnName="streetnumber", null=true, limit=25);
      t.string(columnName="streetname", null=true, limit=50);
      t.string(columnName="suburb", null=true, limit=50);
      t.string(columnName="phone", null=true, limit=25);
      t.string(columnName="email", null=true, limit=50);
      t.integer(columnName="statusid", null=false, default=1);
      t.integer(columnName="accesslevel", null=false, default=1);
      t.integer(columnName="statusid", null=false, default=1);
      t.timestamps();
      t.create();

      /* CLIENTS */
      t = createTable(name='clients', id=true);
      t.integer(columnName="agencyid", null=false);
      t.string(columnName="name", null=false, limit=50);
      t.string(columnName="website", null=false, limit=50);
      t.string(columnName="phone", null=true, limit=25);
      t.string(columnName="email", null=true, limit=50);
      t.integer(columnName="statusid", null=false, default=1);
      t.integer(columnName="accesslevel", null=false, default=1);
      t.integer(columnName="statusid", null=false, default=1);
      t.timestamps();
      t.create();

      /* PUBLISHERS */
      t = createTable(name='publishers', id=true);
      t.integer(columnName="clientid", null=false);
      t.string(columnName="name", null=false, limit=50);
      t.string(columnName="website", null=false, limit=50);
      t.string(columnName="phone", null=true, limit=25);
      t.string(columnName="email", null=true, limit=50);
      t.string(columnName="contactname", null=false, limit=50);
      t.integer(columnName="statusid", null=false, default=1);
      t.integer(columnName="accesslevel", null=false, default=1);
      t.integer(columnName="statusid", null=false, default=1);
      t.timestamps();
      t.create();

      /* CAMPAIGNS */


      /* CLICKS */


      /* ASSETS */


      /* USERLOGS */

    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
      dropTable('tableName');
    </cfscript>
  </cffunction>
</cfcomponent>