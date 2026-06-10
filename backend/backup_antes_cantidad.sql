--
-- PostgreSQL database dump
--

\restrict fVPexQ4S6FAC1kDeUiFfZ35y3YAOe2y4Vyd7jzY6Jbmxnt8AphAJ4MmdgWW2cdd

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.9 (Debian 17.9-0+deb13u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
begin
    if not exists (
        select 1
        from pg_event_trigger_ddl_commands() ev
        join pg_catalog.pg_extension e on ev.objid = e.oid
        where e.extname = 'pg_graphql'
    ) then
        return;
    end if;

    drop function if exists graphql_public.graphql;
    create or replace function graphql_public.graphql(
        "operationName" text default null,
        query text default null,
        variables jsonb default null,
        extensions jsonb default null
    )
        returns jsonb
        language sql
    as $$
        select graphql.resolve(
            query := query,
            variables := coalesce(variables, '{}'),
            "operationName" := "operationName",
            extensions := extensions
        );
    $$;

    -- Attach the wrapper to the extension so DROP EXTENSION cascades to it,
    -- which in turn triggers set_graphql_placeholder to reinstall the "not enabled" stub.
    alter extension pg_graphql add function graphql_public.graphql(text, text, jsonb, jsonb);

    grant usage on schema graphql to postgres, anon, authenticated, service_role;
    grant execute on function graphql.resolve to postgres, anon, authenticated, service_role;
    grant usage on schema graphql to postgres with grant option;
    grant usage on schema graphql_public to postgres with grant option;
end;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: supabase_admin
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;


ALTER FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) OWNER TO supabase_admin;

--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
    -- Regclass of the table e.g. public.notes
    entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

    -- I, U, D, T: insert, update ...
    action realtime.action = (
        case wal ->> 'action'
            when 'I' then 'INSERT'
            when 'U' then 'UPDATE'
            when 'D' then 'DELETE'
            else 'ERROR'
        end
    );

    -- Is row level security enabled for the table
    is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

    subscriptions realtime.subscription[] = array_agg(subs)
        from
            realtime.subscription subs
        where
            subs.entity = entity_
            -- Filter by action early - only get subscriptions interested in this action
            -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
            and (subs.action_filter = '*' or subs.action_filter = action::text);

    -- Subscription vars
    working_role regrole;
    working_selected_columns text[];
    claimed_role regrole;
    claims jsonb;

    subscription_id uuid;
    subscription_has_access bool;
    visible_to_subscription_ids uuid[] = '{}';

    -- structured info for wal's columns
    columns realtime.wal_column[];
    -- previous identity values for update/delete
    old_columns realtime.wal_column[];

    error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

    -- Primary jsonb output for record
    output jsonb;

    -- Loop record for iterating unique roles (outer loop)
    role_record record;
    -- Loop record for iterating unique selected_columns within a role (inner loop)
    cols_record record;
    -- Subscription ids visible at the role level (before fanning out by selected_columns)
    visible_role_sub_ids uuid[] = '{}';

begin
    perform set_config('role', null, true);

    columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'columns') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    old_columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'identity') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    for role_record in
        select claims_role
        from (select distinct claims_role from unnest(subscriptions)) t
        order by claims_role::text
    loop
        working_role := role_record.claims_role;

        -- Update `is_selectable` for columns and old_columns (once per role)
        columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(columns) c;

        old_columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(old_columns) c;

        if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
            -- Fan out 400 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;
            end loop;

        -- The claims role does not have SELECT permission to the primary key of entity
        elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
            -- Fan out 401 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;
            end loop;

        else
            -- Create the prepared statement (once per role)
            if is_rls_enabled and action <> 'DELETE' then
                if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                    deallocate walrus_rls_stmt;
                end if;
                execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
            end if;

            -- Collect all visible subscription IDs for this role (filter check + RLS check)
            visible_role_sub_ids = '{}';

            for subscription_id, claims in (
                    select
                        subs.subscription_id,
                        subs.claims
                    from
                        unnest(subscriptions) subs
                    where
                        subs.entity = entity_
                        and subs.claims_role = working_role
                        and (
                            realtime.is_visible_through_filters(columns, subs.filters)
                            or (
                              action = 'DELETE'
                              and realtime.is_visible_through_filters(old_columns, subs.filters)
                            )
                        )
            ) loop

                if not is_rls_enabled or action = 'DELETE' then
                    visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                else
                    -- Check if RLS allows the role to see the record
                    perform
                        -- Trim leading and trailing quotes from working_role because set_config
                        -- doesn't recognize the role as valid if they are included
                        set_config('role', trim(both '"' from working_role::text), true),
                        set_config('request.jwt.claims', claims::text, true);

                    execute 'execute walrus_rls_stmt' into subscription_has_access;

                    if subscription_has_access then
                        visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                    end if;
                end if;
            end loop;

            perform set_config('role', null, true);

            -- Inner loop: per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;

                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                            left join (
                                select unnest(conkey) as pkey_attnum
                                from pg_constraint
                                where conrelid = entity_ and contype = 'p'
                            ) pk on pk.pkey_attnum = pa.attnum
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                            and (working_selected_columns is null or pa.attname = any(working_selected_columns) or pk.pkey_attnum is not null)
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and (working_selected_columns is null or coalesce((c).name, (oc).name) = any(working_selected_columns) or coalesce((c).is_pkey, (oc).is_pkey))
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Filter visible_role_sub_ids to those matching the current selected_columns group
                visible_to_subscription_ids = coalesce(
                    (
                        select array_agg(s.subscription_id)
                        from unnest(subscriptions) s
                        where s.claims_role = working_role
                          and (s.selected_columns is not distinct from working_selected_columns)
                          and s.subscription_id = any(visible_role_sub_ids)
                    ),
                    '{}'::uuid[]
                );

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;
            end loop;

        end if;
    end loop;

    perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    realtime.wal2json_escape_identifier(nsp.nspname::text)
    || '.'
    || realtime.wal2json_escape_identifier(pc.relname::text)
  FROM pg_class pc
  JOIN pg_namespace nsp ON pc.relnamespace = nsp.oid
  WHERE pc.oid = entity
$$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: send_binary(bytea, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, binary_payload, event, topic, private, extension)
    VALUES (generated_id, payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    col_names text[] = coalesce(
            array_agg(c.column_name order by c.ordinal_position),
            '{}'::text[]
        )
        from
            information_schema.columns c
        where
            format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
            and pg_catalog.has_column_privilege(
                (new.claims ->> 'role'),
                format('%I.%I', c.table_schema, c.table_name)::regclass,
                c.column_name,
                'SELECT'
            );
    table_col_names text[] = coalesce(
            array_agg(pa.attname),
            '{}'::text[]
        )
        from
            pg_attribute pa
        where
            pa.attrelid = new.entity
            and pa.attnum > 0;
    filter realtime.user_defined_filter;
    col_type regtype;
    in_val jsonb;
    selected_col text;
begin
    for filter in select * from unnest(new.filters) loop
        -- Filtered column is valid
        if not filter.column_name = any(col_names) then
            raise exception 'invalid column for filter %', filter.column_name;
        end if;

        -- Type is sanitized and safe for string interpolation
        col_type = (
            select atttypid::regtype
            from pg_catalog.pg_attribute
            where attrelid = new.entity
                  and attname = filter.column_name
        );
        if col_type is null then
            raise exception 'failed to lookup type for column %', filter.column_name;
        end if;
        if filter.op = 'in'::realtime.equality_op then
            in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
            if coalesce(jsonb_array_length(in_val), 0) > 100 then
                raise exception 'too many values for `in` filter. Maximum 100';
            end if;
        else
            -- raises an exception if value is not coercable to type
            perform realtime.cast(filter.value, col_type);
        end if;
    end loop;

    -- Validate that selected_columns reference columns the role can SELECT
    if new.selected_columns is not null then
        for selected_col in select * from unnest(new.selected_columns) loop
            if not selected_col = any(col_names) then
                raise exception 'invalid column for select %', selected_col;
            end if;
        end loop;
    end if;

    -- Apply consistent order to filters so the unique constraint on
    -- (subscription_id, entity, filters) can't be tricked by a different filter order
    new.filters = coalesce(
        array_agg(f order by f.column_name, f.op, f.value),
        '{}'
    ) from unnest(new.filters) f;

    -- Normalize selected_columns order so ARRAY['a','b'] and ARRAY['b','a'] are
    -- treated as the same subscription group in apply_rls
    new.selected_columns = (
        select array_agg(c order by c)
        from unnest(new.selected_columns) c
    );

    return new;
end;
$$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: wal2json_escape_identifier(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.wal2json_escape_identifier(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  -- Prefix `\`, `,`, `.`, and any whitespace with `\`
  SELECT regexp_replace(name, '([\\,.[:space:]])', '\\\1', 'g')
$$;


ALTER FUNCTION realtime.wal2json_escape_identifier(name text) OWNER TO supabase_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Get the last path segment (the actual filename)
    SELECT _parts[array_length(_parts, 1)] INTO _filename;
    -- Extract extension: reverse, split on '.', then reverse again
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint)::bigint as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: tbl_carrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_carrito (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.tbl_carrito OWNER TO postgres;

--
-- Name: tbl_carrito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_carrito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_carrito_id_seq OWNER TO postgres;

--
-- Name: tbl_carrito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_carrito_id_seq OWNED BY public.tbl_carrito.id;


--
-- Name: tbl_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_categoria (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_categoria OWNER TO postgres;

--
-- Name: tbl_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_categoria_id_seq OWNER TO postgres;

--
-- Name: tbl_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_categoria_id_seq OWNED BY public.tbl_categoria.id;


--
-- Name: tbl_chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_chat (
    id integer NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    id_venta_x_producto integer NOT NULL
);


ALTER TABLE public.tbl_chat OWNER TO postgres;

--
-- Name: tbl_chat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_chat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_chat_id_seq OWNER TO postgres;

--
-- Name: tbl_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_chat_id_seq OWNED BY public.tbl_chat.id;


--
-- Name: tbl_imagen_mensaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_imagen_mensaje (
    id integer NOT NULL,
    ruta character varying(150) NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    id_tipo_imagen integer NOT NULL,
    id_chat integer NOT NULL
);


ALTER TABLE public.tbl_imagen_mensaje OWNER TO postgres;

--
-- Name: tbl_imagen_mensaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_imagen_mensaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_imagen_mensaje_id_seq OWNER TO postgres;

--
-- Name: tbl_imagen_mensaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_imagen_mensaje_id_seq OWNED BY public.tbl_imagen_mensaje.id;


--
-- Name: tbl_imagen_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_imagen_producto (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    ruta character varying(150) NOT NULL,
    id_producto integer NOT NULL,
    id_tipo_imagen integer NOT NULL
);


ALTER TABLE public.tbl_imagen_producto OWNER TO postgres;

--
-- Name: tbl_imagen_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_imagen_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_imagen_producto_id_seq OWNER TO postgres;

--
-- Name: tbl_imagen_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_imagen_producto_id_seq OWNED BY public.tbl_imagen_producto.id;


--
-- Name: tbl_mensaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_mensaje (
    id integer NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    contenido text NOT NULL,
    id_chat integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.tbl_mensaje OWNER TO postgres;

--
-- Name: tbl_mensaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_mensaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_mensaje_id_seq OWNER TO postgres;

--
-- Name: tbl_mensaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_mensaje_id_seq OWNED BY public.tbl_mensaje.id;


--
-- Name: tbl_metodo_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_metodo_pago (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    id_pais integer NOT NULL
);


ALTER TABLE public.tbl_metodo_pago OWNER TO postgres;

--
-- Name: tbl_metodo_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_metodo_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_metodo_pago_id_seq OWNER TO postgres;

--
-- Name: tbl_metodo_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_metodo_pago_id_seq OWNED BY public.tbl_metodo_pago.id;


--
-- Name: tbl_notificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_notificacion (
    id integer NOT NULL,
    fecha_notificado timestamp(3) without time zone NOT NULL,
    descripcion text NOT NULL,
    id_producto_deseado integer NOT NULL
);


ALTER TABLE public.tbl_notificacion OWNER TO postgres;

--
-- Name: tbl_notificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_notificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_notificacion_id_seq OWNER TO postgres;

--
-- Name: tbl_notificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_notificacion_id_seq OWNED BY public.tbl_notificacion.id;


--
-- Name: tbl_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_pais (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_pais OWNER TO postgres;

--
-- Name: tbl_pais_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_pais_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_pais_id_seq OWNER TO postgres;

--
-- Name: tbl_pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_pais_id_seq OWNED BY public.tbl_pais.id;


--
-- Name: tbl_precio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_precio (
    id integer NOT NULL,
    precio numeric(20,2) NOT NULL,
    id_pais integer NOT NULL,
    id_producto integer NOT NULL
);


ALTER TABLE public.tbl_precio OWNER TO postgres;

--
-- Name: tbl_precio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_precio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_precio_id_seq OWNER TO postgres;

--
-- Name: tbl_precio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_precio_id_seq OWNED BY public.tbl_precio.id;


--
-- Name: tbl_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_producto (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text NOT NULL,
    id_vendedor integer NOT NULL,
    id_pais integer NOT NULL,
    id_categoria integer NOT NULL,
    id_videojuego integer NOT NULL
);


ALTER TABLE public.tbl_producto OWNER TO postgres;

--
-- Name: tbl_producto_deseado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_producto_deseado (
    id integer NOT NULL,
    precio_objetivo numeric(20,2) NOT NULL,
    id_producto integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.tbl_producto_deseado OWNER TO postgres;

--
-- Name: tbl_producto_deseado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_producto_deseado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_producto_deseado_id_seq OWNER TO postgres;

--
-- Name: tbl_producto_deseado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_producto_deseado_id_seq OWNED BY public.tbl_producto_deseado.id;


--
-- Name: tbl_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_producto_id_seq OWNER TO postgres;

--
-- Name: tbl_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_producto_id_seq OWNED BY public.tbl_producto.id;


--
-- Name: tbl_rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_rol (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_rol OWNER TO postgres;

--
-- Name: tbl_rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_rol_id_seq OWNER TO postgres;

--
-- Name: tbl_rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_rol_id_seq OWNED BY public.tbl_rol.id;


--
-- Name: tbl_tipo_imagen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_tipo_imagen (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_tipo_imagen OWNER TO postgres;

--
-- Name: tbl_tipo_imagen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_tipo_imagen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_tipo_imagen_id_seq OWNER TO postgres;

--
-- Name: tbl_tipo_imagen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_tipo_imagen_id_seq OWNED BY public.tbl_tipo_imagen.id;


--
-- Name: tbl_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_usuario (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    usuario character varying(50) NOT NULL,
    ventas integer NOT NULL,
    correo character varying(200) NOT NULL,
    id_pais integer NOT NULL,
    id_rol integer NOT NULL,
    id_metodo_pago_fav integer NOT NULL
);


ALTER TABLE public.tbl_usuario OWNER TO postgres;

--
-- Name: tbl_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_usuario_id_seq OWNER TO postgres;

--
-- Name: tbl_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_usuario_id_seq OWNED BY public.tbl_usuario.id;


--
-- Name: tbl_valoracion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_valoracion (
    id integer NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    puntaje integer NOT NULL,
    id_venta_x_producto integer NOT NULL
);


ALTER TABLE public.tbl_valoracion OWNER TO postgres;

--
-- Name: tbl_valoracion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_valoracion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_valoracion_id_seq OWNER TO postgres;

--
-- Name: tbl_valoracion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_valoracion_id_seq OWNED BY public.tbl_valoracion.id;


--
-- Name: tbl_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_venta (
    id integer NOT NULL,
    total numeric(30,2) NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    id_usuario integer NOT NULL,
    id_metodo_pago integer NOT NULL
);


ALTER TABLE public.tbl_venta OWNER TO postgres;

--
-- Name: tbl_venta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_venta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_venta_id_seq OWNER TO postgres;

--
-- Name: tbl_venta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_venta_id_seq OWNED BY public.tbl_venta.id;


--
-- Name: tbl_venta_x_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_venta_x_producto (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_venta integer NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(20,2) NOT NULL
);


ALTER TABLE public.tbl_venta_x_producto OWNER TO postgres;

--
-- Name: tbl_venta_x_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_venta_x_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_venta_x_producto_id_seq OWNER TO postgres;

--
-- Name: tbl_venta_x_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_venta_x_producto_id_seq OWNED BY public.tbl_venta_x_producto.id;


--
-- Name: tbl_videojuego; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_videojuego (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_videojuego OWNER TO postgres;

--
-- Name: tbl_videojuego_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_videojuego_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_videojuego_id_seq OWNER TO postgres;

--
-- Name: tbl_videojuego_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_videojuego_id_seq OWNED BY public.tbl_videojuego.id;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    selected_columns text[],
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: tbl_carrito id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_carrito ALTER COLUMN id SET DEFAULT nextval('public.tbl_carrito_id_seq'::regclass);


--
-- Name: tbl_categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_categoria ALTER COLUMN id SET DEFAULT nextval('public.tbl_categoria_id_seq'::regclass);


--
-- Name: tbl_chat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_chat ALTER COLUMN id SET DEFAULT nextval('public.tbl_chat_id_seq'::regclass);


--
-- Name: tbl_imagen_mensaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_mensaje ALTER COLUMN id SET DEFAULT nextval('public.tbl_imagen_mensaje_id_seq'::regclass);


--
-- Name: tbl_imagen_producto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_producto ALTER COLUMN id SET DEFAULT nextval('public.tbl_imagen_producto_id_seq'::regclass);


--
-- Name: tbl_mensaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_mensaje ALTER COLUMN id SET DEFAULT nextval('public.tbl_mensaje_id_seq'::regclass);


--
-- Name: tbl_metodo_pago id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_metodo_pago ALTER COLUMN id SET DEFAULT nextval('public.tbl_metodo_pago_id_seq'::regclass);


--
-- Name: tbl_notificacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_notificacion ALTER COLUMN id SET DEFAULT nextval('public.tbl_notificacion_id_seq'::regclass);


--
-- Name: tbl_pais id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_pais ALTER COLUMN id SET DEFAULT nextval('public.tbl_pais_id_seq'::regclass);


--
-- Name: tbl_precio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_precio ALTER COLUMN id SET DEFAULT nextval('public.tbl_precio_id_seq'::regclass);


--
-- Name: tbl_producto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto ALTER COLUMN id SET DEFAULT nextval('public.tbl_producto_id_seq'::regclass);


--
-- Name: tbl_producto_deseado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto_deseado ALTER COLUMN id SET DEFAULT nextval('public.tbl_producto_deseado_id_seq'::regclass);


--
-- Name: tbl_rol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_rol ALTER COLUMN id SET DEFAULT nextval('public.tbl_rol_id_seq'::regclass);


--
-- Name: tbl_tipo_imagen id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_tipo_imagen ALTER COLUMN id SET DEFAULT nextval('public.tbl_tipo_imagen_id_seq'::regclass);


--
-- Name: tbl_usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuario ALTER COLUMN id SET DEFAULT nextval('public.tbl_usuario_id_seq'::regclass);


--
-- Name: tbl_valoracion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_valoracion ALTER COLUMN id SET DEFAULT nextval('public.tbl_valoracion_id_seq'::regclass);


--
-- Name: tbl_venta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta ALTER COLUMN id SET DEFAULT nextval('public.tbl_venta_id_seq'::regclass);


--
-- Name: tbl_venta_x_producto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta_x_producto ALTER COLUMN id SET DEFAULT nextval('public.tbl_venta_x_producto_id_seq'::regclass);


--
-- Name: tbl_videojuego id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_videojuego ALTER COLUMN id SET DEFAULT nextval('public.tbl_videojuego_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
a85c1ada-cf22-45bd-9dae-49eeb10a7f6c	\N	\N	\N	\N	google			2026-04-30 01:43:30.775749+00	2026-04-30 01:43:30.775749+00	oauth	\N	\N	http://localhost:3000	\N	\N	f
bf84a45c-da45-4d3b-aef9-77130d9994a3	\N	\N	\N	\N	discord			2026-04-30 01:43:36.741849+00	2026-04-30 01:43:36.741849+00	oauth	\N	\N	http://localhost:3000	\N	\N	f
07e07f18-28e9-42fb-aebf-45973710a1ed	\N	\N	\N	\N	google			2026-04-30 01:46:11.814006+00	2026-04-30 01:46:11.814006+00	oauth	\N	\N	http://localhost:3000	\N	\N	f
1ec99ea4-f82a-4e16-ad64-14aefdd8b81f	\N	\N	\N	\N	google			2026-05-01 03:37:43.953664+00	2026-05-01 03:37:43.953664+00	oauth	\N	\N	http://localhost:5000/	\N	\N	f
51777806-25c5-478d-bb90-3f55f0a08242	\N	\N	\N	\N	google			2026-05-01 03:40:24.802414+00	2026-05-01 03:40:24.802414+00	oauth	\N	\N	http://localhost:5000/	\N	\N	f
45e80978-62c4-416d-90e6-6cb51b717d74	\N	\N	\N	\N	google			2026-05-02 02:47:44.447358+00	2026-05-02 02:47:44.447358+00	oauth	\N	\N	https://jshop-h9dvy0k1l-jorgeandru2007-7779s-projects.vercel.app	\N	\N	f
5ef19258-7911-40d3-8849-94b2dcd2d42c	\N	\N	\N	\N	google			2026-06-02 11:00:26.327389+00	2026-06-02 11:00:26.327389+00	oauth	\N	\N	https://jshop-kappa.vercel.app/	\N	\N	f
78989efd-8def-4e92-8d82-f337f5bedc1b	\N	\N	\N	\N	google			2026-06-08 22:17:41.990519+00	2026-06-08 22:17:41.990519+00	oauth	\N	\N	https://jshop-kappa.vercel.app/	\N	\N	f
58bfaf22-ddfc-465a-80a0-d7a61f6e3f58	\N	\N	\N	\N	google			2026-06-08 22:17:59.906195+00	2026-06-08 22:17:59.906195+00	oauth	\N	\N	https://jshop-kappa.vercel.app/	\N	\N	f
4f2180e8-49ba-4b66-8f8b-5d40ca7d9a16	\N	\N	\N	\N	google			2026-06-08 22:18:00.514513+00	2026-06-08 22:18:00.514513+00	oauth	\N	\N	https://jshop-kappa.vercel.app/	\N	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
113618264129395912111	23e95308-1699-4b18-8eca-5c8b8ae1a37a	{"iss": "https://accounts.google.com", "sub": "113618264129395912111", "name": "JORGE ANDRES RUIZ FLORES", "email": "jorgeruizf@iefaz.edu.co", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLpnacHBNXi8T9Dl2t1An9GT4udjr4ICURff89n8d0W-S5jWP8=s96-c", "full_name": "JORGE ANDRES RUIZ FLORES", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocLpnacHBNXi8T9Dl2t1An9GT4udjr4ICURff89n8d0W-S5jWP8=s96-c", "provider_id": "113618264129395912111", "custom_claims": {"hd": "iefaz.edu.co"}, "email_verified": true, "phone_verified": false}	google	2026-06-02 02:49:00.238508+00	2026-06-02 02:49:00.238558+00	2026-06-02 02:49:00.238558+00	eba7b8dc-8f37-4dba-9921-1c19e1c74eb1
831735406025375745	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{"iss": "https://discord.com/api", "sub": "831735406025375745", "name": "l_capitalista#0", "email": "jorgeandru2007@gmail.com", "picture": "https://cdn.discordapp.com/avatars/831735406025375745/73ac71069045600f3d701dd69249d19d.png", "full_name": "l_capitalista", "avatar_url": "https://cdn.discordapp.com/avatars/831735406025375745/73ac71069045600f3d701dd69249d19d.png", "provider_id": "831735406025375745", "custom_claims": {"global_name": "lorito"}, "email_verified": true, "phone_verified": false}	discord	2026-05-01 03:58:24.728786+00	2026-05-01 03:58:24.728836+00	2026-06-08 16:11:24.309633+00	f37db0f3-0e62-42ec-ad8d-b9c3443c2c38
1185635433640636540	472776d5-15e3-4f7e-befb-ac4c22911ee5	{"iss": "https://discord.com/api", "sub": "1185635433640636540", "name": "anrz68#0", "email": "andimois1222@gmail.com", "picture": "https://cdn.discordapp.com/avatars/1185635433640636540/3a6b1848aa6f4b63dd32872c553646ef.png", "full_name": "anrz68", "avatar_url": "https://cdn.discordapp.com/avatars/1185635433640636540/3a6b1848aa6f4b63dd32872c553646ef.png", "provider_id": "1185635433640636540", "custom_claims": {"global_name": "andru"}, "email_verified": true, "phone_verified": false}	discord	2026-06-08 21:04:39.840401+00	2026-06-08 21:04:39.840448+00	2026-06-08 21:04:39.840448+00	9e496840-cfbc-41e9-8556-f2f1b96f7228
113872139681872641238	67af4f7e-8864-4397-b69c-d90c3ffd6216	{"iss": "https://accounts.google.com", "sub": "113872139681872641238", "name": "Jorge Andres Ruiz Flores", "email": "jorgeandruruiz2007@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocI9x3i2rHyoeXtmcZSCLZEo60bGVIoDuyIwF9AKqAbld9nw_j-Q=s96-c", "full_name": "Jorge Andres Ruiz Flores", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocI9x3i2rHyoeXtmcZSCLZEo60bGVIoDuyIwF9AKqAbld9nw_j-Q=s96-c", "provider_id": "113872139681872641238", "email_verified": true, "phone_verified": false}	google	2026-05-01 04:14:17.899414+00	2026-05-01 04:14:17.899464+00	2026-06-08 22:17:40.10583+00	33a0febb-7d39-4d6a-b274-01946a809426
106401334766871683585	18a69c00-a223-4d66-8d04-81604e78bb64	{"iss": "https://accounts.google.com", "sub": "106401334766871683585", "name": "Adriel jeshua Jiménez marquez", "email": "jeshuajimenezmarquez@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocK5fjgBSMRNhuprevlIQorM-UGxygMtatScflaGBvesVEPgSJ9a=s96-c", "full_name": "Adriel jeshua Jiménez marquez", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocK5fjgBSMRNhuprevlIQorM-UGxygMtatScflaGBvesVEPgSJ9a=s96-c", "provider_id": "106401334766871683585", "email_verified": true, "phone_verified": false}	google	2026-06-08 22:18:14.041069+00	2026-06-08 22:18:14.041112+00	2026-06-08 22:18:14.041112+00	d3d24c6a-b48d-4339-9af6-905c2c07e5a6
115485632212987330027	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{"iss": "https://accounts.google.com", "sub": "115485632212987330027", "name": "Jorge Ruiz", "email": "jorgeandru2007@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKPKs-wo-3yWcRjYhVGOffrgzjGB9zLf9YGzcey3BnxpIEiCpg=s96-c", "full_name": "Jorge Ruiz", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKPKs-wo-3yWcRjYhVGOffrgzjGB9zLf9YGzcey3BnxpIEiCpg=s96-c", "provider_id": "115485632212987330027", "email_verified": true, "phone_verified": false}	google	2026-05-01 03:58:43.827657+00	2026-05-01 03:58:43.827731+00	2026-06-08 03:51:46.370594+00	dffd28a7-928a-4146-83fc-1f640c7b28d8
105497616570033014178	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	{"iss": "https://accounts.google.com", "sub": "105497616570033014178", "name": "JORGE ANDRÉS RUIZ FLORES", "email": "jorge.ruizf@udea.edu.co", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJMdMRnXXLjvg9rlNHLyJx4XzwHK6kRBpMSTmx5zFAz6Y1rymI=s96-c", "full_name": "JORGE ANDRÉS RUIZ FLORES", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJMdMRnXXLjvg9rlNHLyJx4XzwHK6kRBpMSTmx5zFAz6Y1rymI=s96-c", "provider_id": "105497616570033014178", "custom_claims": {"hd": "udea.edu.co"}, "email_verified": true, "phone_verified": false}	google	2026-04-30 01:44:00.823387+00	2026-04-30 01:44:00.823455+00	2026-06-08 04:49:12.746173+00	837e753a-57b7-4875-8bfa-05d834574ccd
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
854b40ce-6bf4-49ae-ae25-49be5fece334	2026-04-30 01:44:00.86151+00	2026-04-30 01:44:00.86151+00	oauth	3f529e63-fe3c-46b8-8157-8f358704d20f
fc8c8fdc-b114-49da-b670-90dc6a947448	2026-05-01 03:58:24.765065+00	2026-05-01 03:58:24.765065+00	oauth	d1d5f864-3c10-4485-b22e-283409953d4b
cfcca073-577f-47a1-9924-39d9d4b5e936	2026-05-01 03:58:43.835795+00	2026-05-01 03:58:43.835795+00	oauth	9f12c9db-b3c9-4995-bc4c-187d7ee8fb72
ed36ee5d-eec5-4529-8a3f-9e7bb194eaaf	2026-05-01 03:59:18.451108+00	2026-05-01 03:59:18.451108+00	oauth	4702cae6-730a-4945-96b8-b98323b19054
c7929b80-eeb0-46e8-87ea-36770b141453	2026-05-01 04:03:03.5455+00	2026-05-01 04:03:03.5455+00	oauth	0b25bd3c-ca3a-4583-9316-cbd32c411734
29814610-2773-484b-98fd-d902a14dad65	2026-05-01 04:04:59.263946+00	2026-05-01 04:04:59.263946+00	oauth	4a1b5906-7feb-4d05-bff1-db5807374b77
44faa15f-138d-4ea1-baa9-87d6a9e64a47	2026-05-01 04:14:17.919298+00	2026-05-01 04:14:17.919298+00	oauth	1fb60353-131b-4638-95d6-f70088570b2b
59e4fc6f-db5a-4b52-a69b-c67bde257083	2026-05-01 23:31:53.585526+00	2026-05-01 23:31:53.585526+00	oauth	9555c44f-e168-4d15-9bab-7a7cd83009cc
d65b4f33-c0ab-4364-9a6f-83dca31a6abf	2026-05-01 23:32:13.696336+00	2026-05-01 23:32:13.696336+00	oauth	ae64039c-404d-4ebe-af39-a6f28684e611
70a5e2af-bdea-4a98-92e5-e8fd865d3988	2026-05-01 23:39:30.142895+00	2026-05-01 23:39:30.142895+00	oauth	604bf8dd-f4c8-4f24-b662-0429df8d3364
fd3a1c24-47b8-44d7-a0bb-121acbdc6cd4	2026-05-01 23:53:01.308887+00	2026-05-01 23:53:01.308887+00	oauth	62f4af06-bb84-4267-90e4-0b11cd11d890
58e808d0-4f2c-4d6b-96fd-fb87e7164633	2026-05-01 23:53:52.303867+00	2026-05-01 23:53:52.303867+00	oauth	234a79e8-2886-46d1-b4ec-bf0f8f9af467
d662e3b4-57f2-4bbc-9094-889b310fc207	2026-05-02 00:08:07.033073+00	2026-05-02 00:08:07.033073+00	oauth	2c9861ba-df95-444b-a4ad-a5136b43ecf2
29f3b2c5-b5bd-4c4f-b293-1aa689c816c0	2026-05-02 00:17:43.734217+00	2026-05-02 00:17:43.734217+00	oauth	02e76cad-1858-4102-95fd-68f16319110b
2acde7c3-916a-4031-9ffe-be3e911d4538	2026-05-02 00:31:34.270011+00	2026-05-02 00:31:34.270011+00	oauth	71d203be-cd82-4cc7-8036-28373f1fb3a9
97e1e550-7cf8-4498-88bf-b62f4d631550	2026-05-02 02:47:48.763035+00	2026-05-02 02:47:48.763035+00	oauth	d8ff8b21-c3a7-4111-9c4b-feb673fb195f
5f01476e-b315-4df9-8f20-35c473aff97a	2026-05-02 02:48:16.462766+00	2026-05-02 02:48:16.462766+00	oauth	4be8ec02-8a46-457c-8985-8e3544f6a81f
e4e46118-37ba-488a-8e22-d9acc153f77a	2026-05-02 02:57:06.560932+00	2026-05-02 02:57:06.560932+00	oauth	e675a869-7fb9-475d-9c95-0ae258cbf023
9cc6d4d0-8fb3-4da4-a39e-98c3a7eed4a7	2026-05-02 02:58:38.613118+00	2026-05-02 02:58:38.613118+00	oauth	ef2420f9-2cc3-4fd1-9418-4d1cb4bb58d3
948a1724-081c-4301-a235-c87a4222773c	2026-05-02 03:09:25.422609+00	2026-05-02 03:09:25.422609+00	oauth	51466c86-04b7-4fa0-96fd-7c97b8044cc1
4515bb40-8433-4aa2-84f2-cf0e8668e725	2026-05-02 03:10:58.864012+00	2026-05-02 03:10:58.864012+00	oauth	d5a9dbaf-6e9b-4eb1-b796-7f2a49363673
62267bf1-2f22-4d97-8fdb-d1738013e579	2026-05-02 03:17:53.719155+00	2026-05-02 03:17:53.719155+00	oauth	b21aa2a4-254e-4f4d-a0cd-ae7c3da2cb2e
03b885b5-d0a6-4e44-a225-7f9d63c806e8	2026-05-02 03:18:09.685662+00	2026-05-02 03:18:09.685662+00	oauth	3119e513-23c3-491e-8ace-03a967ccab48
73b456be-1a73-4f0f-a0b1-849623a7ebc1	2026-05-02 03:20:06.086996+00	2026-05-02 03:20:06.086996+00	oauth	672954ce-bf8b-47ff-a287-34baa59a9cb1
6d36c45c-6b7f-4821-8a2c-3e6837bfa477	2026-05-02 03:20:50.32262+00	2026-05-02 03:20:50.32262+00	oauth	2effc951-e5c2-4162-8b5e-14950f4542c2
c65754a0-e482-4663-8672-4a3d274cdc57	2026-05-13 23:14:59.122029+00	2026-05-13 23:14:59.122029+00	oauth	36ee18d6-26c5-4e22-bbe4-94d781f1605a
ca4cebe4-fdac-4a26-bbf2-bcddc3452789	2026-05-14 01:11:26.208644+00	2026-05-14 01:11:26.208644+00	oauth	c2eb111d-cd47-48f8-baed-c00ad669caeb
cfe9de1f-f045-49bc-8816-62b97395e314	2026-05-27 02:36:43.834445+00	2026-05-27 02:36:43.834445+00	oauth	fd62014f-b42e-46e4-8f90-70479a9f25ce
4796a75e-2ce0-4835-9c86-7eb99aab4805	2026-05-27 02:37:11.173211+00	2026-05-27 02:37:11.173211+00	oauth	e536c0c5-6289-4f7e-9f72-f48eed578658
f2db915a-1dd3-4dc1-b48b-d4aa4a268f3b	2026-05-27 02:37:22.94311+00	2026-05-27 02:37:22.94311+00	oauth	fb0b6db7-1ca7-4a09-8207-397c6a20766b
06aa4c79-e535-44d4-8c6e-866d48ebca57	2026-05-27 23:35:04.373933+00	2026-05-27 23:35:04.373933+00	oauth	ac89de26-4d74-49e7-b184-abf0bd3dd406
94d3da27-5f51-4eb9-a81f-ec28b024b849	2026-05-28 15:19:47.024758+00	2026-05-28 15:19:47.024758+00	oauth	41ff2b9a-981f-4840-a5c9-cf2270907a64
99e5e8b5-2252-45a4-97ae-f1ba4631acd3	2026-05-28 15:20:21.423849+00	2026-05-28 15:20:21.423849+00	oauth	565333d0-3366-44fe-9b82-4679e23e84e2
3151f1f4-7c39-4d76-8309-99aa84359450	2026-05-28 15:49:50.302871+00	2026-05-28 15:49:50.302871+00	oauth	f3087bf8-6a4d-4ca9-b9ea-4b5d5825a5d3
1315e57f-a969-4505-84e2-490bf0ce8284	2026-05-31 23:43:09.18484+00	2026-05-31 23:43:09.18484+00	oauth	893fbbaf-38f1-45c9-b447-235bcf519aaa
5a3014e8-c137-480e-ab71-878ce8d2568f	2026-06-01 15:23:07.035428+00	2026-06-01 15:23:07.035428+00	oauth	02c55c54-e802-400a-bd56-0096cf2d0418
ae8efa39-debf-4e96-b935-8bd160ee1d6b	2026-06-01 15:27:55.708393+00	2026-06-01 15:27:55.708393+00	oauth	bcd3beee-0bb3-4d77-b199-13123247fecb
e0bda8af-e304-4b53-87f2-287758ea7172	2026-06-01 22:49:27.311097+00	2026-06-01 22:49:27.311097+00	oauth	c73ccabe-90f2-43a3-95ef-7351c5768fab
d642f222-e601-45a7-a664-f4630eae044c	2026-06-01 22:50:06.984021+00	2026-06-01 22:50:06.984021+00	oauth	f6b8a942-0c34-4ce8-9def-f92720cc0390
13634952-040c-435c-b682-298114526a95	2026-06-02 02:09:27.090653+00	2026-06-02 02:09:27.090653+00	oauth	9d49b34a-50b6-408e-999c-b71bb62d0cc3
743a3787-9307-4b90-b80e-053ee6b1da69	2026-06-02 02:49:00.253683+00	2026-06-02 02:49:00.253683+00	oauth	77d7d28f-cbe6-4725-8f96-a6ffa271d68d
a9ae548f-a283-4be2-a4af-0b85e932f253	2026-06-02 02:50:03.585671+00	2026-06-02 02:50:03.585671+00	oauth	d1918509-ce68-4f46-9598-a7764a9d945d
e0e226e5-1021-4737-8471-acf4cdbc1a41	2026-06-02 11:00:34.39368+00	2026-06-02 11:00:34.39368+00	oauth	c281941a-949a-49aa-9b3c-6863d8a5b9ad
64c3967f-92cf-40a6-97b1-a037857dd7b1	2026-06-07 17:06:30.874699+00	2026-06-07 17:06:30.874699+00	oauth	1ee98d17-2d2c-4dd8-8f22-a18619f9ac90
91521793-d0cf-445c-8e71-02a73b4ac1a0	2026-06-07 21:01:37.919833+00	2026-06-07 21:01:37.919833+00	oauth	7b7c616d-d2d8-4c85-98b2-cd0d2dcfe638
73ff0909-9d26-4cee-a898-8e2d1dd9ae68	2026-06-08 03:51:46.413129+00	2026-06-08 03:51:46.413129+00	oauth	b31094c7-746e-45a4-bd50-ea883f54f025
9bbac689-9934-4dee-beaf-1a585a7cb07d	2026-06-08 04:49:12.769564+00	2026-06-08 04:49:12.769564+00	oauth	79e0d2ff-c082-4b4c-b2a8-3e784e2270dc
587f0c79-d8f4-4b3b-aa22-6c97eda20c6d	2026-06-08 16:11:24.342113+00	2026-06-08 16:11:24.342113+00	oauth	d9667b6a-f053-46b0-820c-e3f45f58e8e8
aaa25754-212e-41d9-9b5d-f673c68caded	2026-06-08 21:04:39.873344+00	2026-06-08 21:04:39.873344+00	oauth	6f3dedd8-6e2c-434d-91b0-cae3c9d4a8d2
b800c021-2134-445d-92a1-4404ebeeab4c	2026-06-08 22:17:40.13856+00	2026-06-08 22:17:40.13856+00	oauth	7176c9ad-de68-4185-940e-7460b1a6e547
2484727f-c3c4-49f1-b98a-74a9ccbb22f9	2026-06-08 22:18:14.051564+00	2026-06-08 22:18:14.051564+00	oauth	1d727315-0d6f-4673-822c-09466e3f91be
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	lvx4cine7chq	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-04-30 01:44:00.849955+00	2026-04-30 01:44:00.849955+00	\N	854b40ce-6bf4-49ae-ae25-49be5fece334
00000000-0000-0000-0000-000000000000	2	5y2d4nmvr2kt	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-01 03:58:24.751552+00	2026-05-01 03:58:24.751552+00	\N	fc8c8fdc-b114-49da-b670-90dc6a947448
00000000-0000-0000-0000-000000000000	3	ybeq3hfl7rrl	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-01 03:58:43.834472+00	2026-05-01 03:58:43.834472+00	\N	cfcca073-577f-47a1-9924-39d9d4b5e936
00000000-0000-0000-0000-000000000000	4	ch5b3z4inmis	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-01 03:59:18.449569+00	2026-05-01 03:59:18.449569+00	\N	ed36ee5d-eec5-4529-8a3f-9e7bb194eaaf
00000000-0000-0000-0000-000000000000	5	qslqs4vf6li3	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-01 04:03:03.542981+00	2026-05-01 04:03:03.542981+00	\N	c7929b80-eeb0-46e8-87ea-36770b141453
00000000-0000-0000-0000-000000000000	6	4fgwnsvw5eur	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-01 04:04:59.261666+00	2026-05-01 04:04:59.261666+00	\N	29814610-2773-484b-98fd-d902a14dad65
00000000-0000-0000-0000-000000000000	7	d4cxyyu3xnnd	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-05-01 04:14:17.916374+00	2026-05-01 23:23:28.369924+00	\N	44faa15f-138d-4ea1-baa9-87d6a9e64a47
00000000-0000-0000-0000-000000000000	8	fo37j47o6wjb	67af4f7e-8864-4397-b69c-d90c3ffd6216	f	2026-05-01 23:23:28.38953+00	2026-05-01 23:23:28.38953+00	d4cxyyu3xnnd	44faa15f-138d-4ea1-baa9-87d6a9e64a47
00000000-0000-0000-0000-000000000000	9	xqz2yya7bkwq	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-01 23:31:53.580635+00	2026-05-01 23:31:53.580635+00	\N	59e4fc6f-db5a-4b52-a69b-c67bde257083
00000000-0000-0000-0000-000000000000	10	qmqrw4yuyg4g	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-01 23:32:13.693864+00	2026-05-01 23:32:13.693864+00	\N	d65b4f33-c0ab-4364-9a6f-83dca31a6abf
00000000-0000-0000-0000-000000000000	11	u6cucltsblla	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-01 23:39:30.140528+00	2026-05-01 23:39:30.140528+00	\N	70a5e2af-bdea-4a98-92e5-e8fd865d3988
00000000-0000-0000-0000-000000000000	12	gwoaptb32oso	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-01 23:53:01.305819+00	2026-05-01 23:53:01.305819+00	\N	fd3a1c24-47b8-44d7-a0bb-121acbdc6cd4
00000000-0000-0000-0000-000000000000	14	zdvvxpe5lewh	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 00:08:07.027601+00	2026-05-02 00:08:07.027601+00	\N	d662e3b4-57f2-4bbc-9094-889b310fc207
00000000-0000-0000-0000-000000000000	15	bqzgshk3oxl2	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 00:17:43.73169+00	2026-05-02 00:17:43.73169+00	\N	29f3b2c5-b5bd-4c4f-b293-1aa689c816c0
00000000-0000-0000-0000-000000000000	17	e6rkf3hi3owh	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-02 02:47:48.734682+00	2026-05-02 02:47:48.734682+00	\N	97e1e550-7cf8-4498-88bf-b62f4d631550
00000000-0000-0000-0000-000000000000	18	ohf5mq45sljx	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 02:48:16.461362+00	2026-05-02 02:48:16.461362+00	\N	5f01476e-b315-4df9-8f20-35c473aff97a
00000000-0000-0000-0000-000000000000	16	apakppuywabk	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-02 00:31:34.253647+00	2026-05-02 02:56:48.806747+00	\N	2acde7c3-916a-4031-9ffe-be3e911d4538
00000000-0000-0000-0000-000000000000	19	7d5jxndmcqog	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 02:56:48.813243+00	2026-05-02 02:56:48.813243+00	apakppuywabk	2acde7c3-916a-4031-9ffe-be3e911d4538
00000000-0000-0000-0000-000000000000	20	gbajlduzm26f	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 02:57:06.558704+00	2026-05-02 02:57:06.558704+00	\N	e4e46118-37ba-488a-8e22-d9acc153f77a
00000000-0000-0000-0000-000000000000	21	ahiucv4k46qx	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 02:58:38.610651+00	2026-05-02 02:58:38.610651+00	\N	9cc6d4d0-8fb3-4da4-a39e-98c3a7eed4a7
00000000-0000-0000-0000-000000000000	13	ydcubesuq7er	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-05-01 23:53:52.300754+00	2026-05-02 02:59:40.050331+00	\N	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	23	hlxvtdjdbfou	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 03:09:25.418534+00	2026-05-02 03:09:25.418534+00	\N	948a1724-081c-4301-a235-c87a4222773c
00000000-0000-0000-0000-000000000000	24	rm74nnfxmqha	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 03:10:58.862556+00	2026-05-02 03:10:58.862556+00	\N	4515bb40-8433-4aa2-84f2-cf0e8668e725
00000000-0000-0000-0000-000000000000	25	ebtqy3drxgd2	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 03:17:53.715293+00	2026-05-02 03:17:53.715293+00	\N	62267bf1-2f22-4d97-8fdb-d1738013e579
00000000-0000-0000-0000-000000000000	26	4fpilmxg3c7j	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-02 03:18:09.683135+00	2026-05-02 03:18:09.683135+00	\N	03b885b5-d0a6-4e44-a225-7f9d63c806e8
00000000-0000-0000-0000-000000000000	27	rlpbqr3oalgt	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-02 03:20:06.083095+00	2026-05-02 03:20:06.083095+00	\N	73b456be-1a73-4f0f-a0b1-849623a7ebc1
00000000-0000-0000-0000-000000000000	28	2zz36jdnwhfd	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-02 03:20:50.321187+00	2026-05-02 03:20:50.321187+00	\N	6d36c45c-6b7f-4821-8a2c-3e6837bfa477
00000000-0000-0000-0000-000000000000	29	6alvuspqn5og	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-13 23:14:59.103977+00	2026-05-14 01:11:14.985733+00	\N	c65754a0-e482-4663-8672-4a3d274cdc57
00000000-0000-0000-0000-000000000000	30	lhrmwcd2qe4c	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-14 01:11:14.99203+00	2026-05-14 01:11:14.99203+00	6alvuspqn5og	c65754a0-e482-4663-8672-4a3d274cdc57
00000000-0000-0000-0000-000000000000	31	2h2aoisgaom5	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-14 01:11:26.207007+00	2026-05-27 02:36:35.020432+00	\N	ca4cebe4-fdac-4a26-bbf2-bcddc3452789
00000000-0000-0000-0000-000000000000	32	34ywz6wjd5sc	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-27 02:36:35.028923+00	2026-05-27 02:36:35.028923+00	2h2aoisgaom5	ca4cebe4-fdac-4a26-bbf2-bcddc3452789
00000000-0000-0000-0000-000000000000	33	wif7j7cjir4l	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-27 02:36:43.828836+00	2026-05-27 02:36:43.828836+00	\N	cfe9de1f-f045-49bc-8816-62b97395e314
00000000-0000-0000-0000-000000000000	34	ckhccycadvmm	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-27 02:37:11.171926+00	2026-05-27 02:37:11.171926+00	\N	4796a75e-2ce0-4835-9c86-7eb99aab4805
00000000-0000-0000-0000-000000000000	35	mwuedcy5k5q3	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	t	2026-05-27 02:37:22.941705+00	2026-05-27 23:33:34.534206+00	\N	f2db915a-1dd3-4dc1-b48b-d4aa4a268f3b
00000000-0000-0000-0000-000000000000	36	77hzjhy3jnkw	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-27 23:33:34.553195+00	2026-05-27 23:33:34.553195+00	mwuedcy5k5q3	f2db915a-1dd3-4dc1-b48b-d4aa4a268f3b
00000000-0000-0000-0000-000000000000	37	pgq5pg2cxdfr	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	t	2026-05-27 23:35:04.363514+00	2026-05-28 15:18:52.123874+00	\N	06aa4c79-e535-44d4-8c6e-866d48ebca57
00000000-0000-0000-0000-000000000000	38	kggtztekggfk	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-28 15:18:52.137466+00	2026-05-28 15:18:52.137466+00	pgq5pg2cxdfr	06aa4c79-e535-44d4-8c6e-866d48ebca57
00000000-0000-0000-0000-000000000000	39	qhxbzxofibxp	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-28 15:19:47.021212+00	2026-05-28 15:19:47.021212+00	\N	94d3da27-5f51-4eb9-a81f-ec28b024b849
00000000-0000-0000-0000-000000000000	40	wmjsc2rjjlzt	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-05-28 15:20:21.422589+00	2026-05-28 15:20:21.422589+00	\N	99e5e8b5-2252-45a4-97ae-f1ba4631acd3
00000000-0000-0000-0000-000000000000	41	a5hbxk2hsrhb	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-28 15:49:50.300277+00	2026-05-28 20:12:28.323431+00	\N	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	42	cemnqqtimwsq	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-28 20:12:28.333284+00	2026-05-28 21:10:45.333166+00	a5hbxk2hsrhb	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	43	k34msnyfzgih	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-28 21:10:45.34189+00	2026-05-28 22:09:15.434391+00	cemnqqtimwsq	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	44	cjo45cgl5kde	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-28 22:09:15.44216+00	2026-05-28 23:11:02.64434+00	k34msnyfzgih	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	45	puaoe3rrntp2	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-28 23:11:02.654467+00	2026-05-29 00:23:25.666486+00	cjo45cgl5kde	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	46	mv24j3tcxa62	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-29 00:23:25.68375+00	2026-05-29 01:21:36.314985+00	puaoe3rrntp2	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	47	63c5avgqpsef	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-05-29 01:21:36.334395+00	2026-05-31 23:42:56.293484+00	mv24j3tcxa62	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	48	napdca3ofzca	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-31 23:42:56.312204+00	2026-05-31 23:42:56.312204+00	63c5avgqpsef	3151f1f4-7c39-4d76-8309-99aa84359450
00000000-0000-0000-0000-000000000000	49	5hvye3h22j4b	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-05-31 23:43:09.178698+00	2026-05-31 23:43:09.178698+00	\N	1315e57f-a969-4505-84e2-490bf0ce8284
00000000-0000-0000-0000-000000000000	22	uwtmd5mywebz	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-05-02 02:59:40.052626+00	2026-06-01 15:23:00.214954+00	ydcubesuq7er	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	51	c5scyjn5yazb	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-01 15:23:07.030517+00	2026-06-01 15:23:07.030517+00	\N	5a3014e8-c137-480e-ab71-878ce8d2568f
00000000-0000-0000-0000-000000000000	50	fntuwihy7ik3	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-01 15:23:00.228158+00	2026-06-01 19:58:20.154467+00	uwtmd5mywebz	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	52	cn4xpizihlwc	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-01 15:27:55.705348+00	2026-06-01 22:43:57.342934+00	\N	ae8efa39-debf-4e96-b935-8bd160ee1d6b
00000000-0000-0000-0000-000000000000	53	ooqflbmh3sr7	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-01 19:58:20.167237+00	2026-06-01 21:33:44.986241+00	fntuwihy7ik3	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	54	v4xts7x3lx2x	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-01 21:33:44.998772+00	2026-06-01 22:32:27.232508+00	ooqflbmh3sr7	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	56	omoxrgyrrbzz	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-01 22:43:57.347576+00	2026-06-01 22:43:57.347576+00	cn4xpizihlwc	ae8efa39-debf-4e96-b935-8bd160ee1d6b
00000000-0000-0000-0000-000000000000	57	r5labwa34qga	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-01 22:49:27.299621+00	2026-06-01 22:49:27.299621+00	\N	e0bda8af-e304-4b53-87f2-287758ea7172
00000000-0000-0000-0000-000000000000	58	d2fbzwftyety	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-01 22:50:06.982635+00	2026-06-01 23:48:21.360755+00	\N	d642f222-e601-45a7-a664-f4630eae044c
00000000-0000-0000-0000-000000000000	59	zmeuuaypm37b	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-01 23:48:21.370351+00	2026-06-02 00:46:38.020076+00	d2fbzwftyety	d642f222-e601-45a7-a664-f4630eae044c
00000000-0000-0000-0000-000000000000	55	bh7hjjxjx6ke	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-01 22:32:27.238813+00	2026-06-02 01:08:07.328848+00	v4xts7x3lx2x	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	60	zpixjknhm2c5	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-02 00:46:38.02886+00	2026-06-02 01:53:20.483551+00	zmeuuaypm37b	d642f222-e601-45a7-a664-f4630eae044c
00000000-0000-0000-0000-000000000000	62	j7gtg6k2qozv	67af4f7e-8864-4397-b69c-d90c3ffd6216	f	2026-06-02 01:53:20.490343+00	2026-06-02 01:53:20.490343+00	zpixjknhm2c5	d642f222-e601-45a7-a664-f4630eae044c
00000000-0000-0000-0000-000000000000	63	x2g2ejxxyd72	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-06-02 02:09:27.084574+00	2026-06-02 02:09:27.084574+00	\N	13634952-040c-435c-b682-298114526a95
00000000-0000-0000-0000-000000000000	61	hbnjguchnnps	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-02 01:08:07.332274+00	2026-06-02 02:36:47.234454+00	bh7hjjxjx6ke	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	65	mimydeduvgnh	23e95308-1699-4b18-8eca-5c8b8ae1a37a	f	2026-06-02 02:49:00.250533+00	2026-06-02 02:49:00.250533+00	\N	743a3787-9307-4b90-b80e-053ee6b1da69
00000000-0000-0000-0000-000000000000	67	ix6cbfunbtdo	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-02 11:00:34.383129+00	2026-06-02 11:00:34.383129+00	\N	e0e226e5-1021-4737-8471-acf4cdbc1a41
00000000-0000-0000-0000-000000000000	66	4kw5hyenicmm	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-02 02:50:03.584292+00	2026-06-02 21:25:26.161944+00	\N	a9ae548f-a283-4be2-a4af-0b85e932f253
00000000-0000-0000-0000-000000000000	64	hdrmuh4mr362	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-02 02:36:47.243027+00	2026-06-02 22:03:46.487621+00	hbnjguchnnps	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	68	e52jtelnfhi3	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-02 21:25:26.185164+00	2026-06-02 22:31:55.428181+00	4kw5hyenicmm	a9ae548f-a283-4be2-a4af-0b85e932f253
00000000-0000-0000-0000-000000000000	70	hpqom4efo6hq	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-02 22:31:55.437919+00	2026-06-02 23:43:29.969778+00	e52jtelnfhi3	a9ae548f-a283-4be2-a4af-0b85e932f253
00000000-0000-0000-0000-000000000000	71	4tibicysml4b	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-02 23:43:29.987731+00	2026-06-03 00:46:45.866308+00	hpqom4efo6hq	a9ae548f-a283-4be2-a4af-0b85e932f253
00000000-0000-0000-0000-000000000000	72	bsi54kseigt2	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-03 00:46:45.871779+00	2026-06-07 16:59:52.570803+00	4tibicysml4b	a9ae548f-a283-4be2-a4af-0b85e932f253
00000000-0000-0000-0000-000000000000	73	mdcamrzqprkf	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-07 16:59:52.582018+00	2026-06-07 16:59:52.582018+00	bsi54kseigt2	a9ae548f-a283-4be2-a4af-0b85e932f253
00000000-0000-0000-0000-000000000000	74	edgqo4zrtf3v	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-07 17:06:30.87175+00	2026-06-07 18:04:53.152169+00	\N	64c3967f-92cf-40a6-97b1-a037857dd7b1
00000000-0000-0000-0000-000000000000	75	2w3o27ew46ih	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-07 18:04:53.161083+00	2026-06-07 19:03:23.263071+00	edgqo4zrtf3v	64c3967f-92cf-40a6-97b1-a037857dd7b1
00000000-0000-0000-0000-000000000000	76	7azsh27ddikm	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-07 19:03:23.273431+00	2026-06-07 20:01:53.25331+00	2w3o27ew46ih	64c3967f-92cf-40a6-97b1-a037857dd7b1
00000000-0000-0000-0000-000000000000	77	koohy3zy2kmc	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-07 20:01:53.259543+00	2026-06-07 20:59:54.01643+00	7azsh27ddikm	64c3967f-92cf-40a6-97b1-a037857dd7b1
00000000-0000-0000-0000-000000000000	78	5ugaxpbp5pmr	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-07 20:59:54.023546+00	2026-06-07 20:59:54.023546+00	koohy3zy2kmc	64c3967f-92cf-40a6-97b1-a037857dd7b1
00000000-0000-0000-0000-000000000000	79	kol45cmrrrj7	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	t	2026-06-07 21:01:37.90909+00	2026-06-07 22:35:14.507188+00	\N	91521793-d0cf-445c-8e71-02a73b4ac1a0
00000000-0000-0000-0000-000000000000	80	wx36fyscpc37	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	t	2026-06-07 22:35:14.518173+00	2026-06-07 23:35:27.272472+00	kol45cmrrrj7	91521793-d0cf-445c-8e71-02a73b4ac1a0
00000000-0000-0000-0000-000000000000	69	6jqzb3y3gvt7	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-02 22:03:46.497194+00	2026-06-08 03:09:19.855646+00	hdrmuh4mr362	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	82	sxcgg6ayiuim	67af4f7e-8864-4397-b69c-d90c3ffd6216	f	2026-06-08 03:09:19.862461+00	2026-06-08 03:09:19.862461+00	6jqzb3y3gvt7	58e808d0-4f2c-4d6b-96fd-fb87e7164633
00000000-0000-0000-0000-000000000000	81	fxq2ktcceli6	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	t	2026-06-07 23:35:27.286087+00	2026-06-08 03:12:20.145096+00	wx36fyscpc37	91521793-d0cf-445c-8e71-02a73b4ac1a0
00000000-0000-0000-0000-000000000000	83	haud4mvgrvz5	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-06-08 03:12:20.149113+00	2026-06-08 03:12:20.149113+00	fxq2ktcceli6	91521793-d0cf-445c-8e71-02a73b4ac1a0
00000000-0000-0000-0000-000000000000	84	mollmtzy6eoc	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-08 03:51:46.390208+00	2026-06-08 03:51:46.390208+00	\N	73ff0909-9d26-4cee-a898-8e2d1dd9ae68
00000000-0000-0000-0000-000000000000	85	mjzaxsx5k7tg	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	t	2026-06-08 04:49:12.756284+00	2026-06-08 16:07:29.86991+00	\N	9bbac689-9934-4dee-beaf-1a585a7cb07d
00000000-0000-0000-0000-000000000000	86	bipw6ou36vd3	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	f	2026-06-08 16:07:29.889103+00	2026-06-08 16:07:29.889103+00	mjzaxsx5k7tg	9bbac689-9934-4dee-beaf-1a585a7cb07d
00000000-0000-0000-0000-000000000000	87	gtodtibzebob	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-08 16:11:24.339747+00	2026-06-08 17:50:39.602601+00	\N	587f0c79-d8f4-4b3b-aa22-6c97eda20c6d
00000000-0000-0000-0000-000000000000	88	2v7rq4cz2qbd	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-08 17:50:39.61977+00	2026-06-08 20:29:37.420898+00	gtodtibzebob	587f0c79-d8f4-4b3b-aa22-6c97eda20c6d
00000000-0000-0000-0000-000000000000	90	4warg2hnxkb5	472776d5-15e3-4f7e-befb-ac4c22911ee5	f	2026-06-08 21:04:39.859982+00	2026-06-08 21:04:39.859982+00	\N	aaa25754-212e-41d9-9b5d-f673c68caded
00000000-0000-0000-0000-000000000000	89	hsrtld6r6vfx	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	t	2026-06-08 20:29:37.431209+00	2026-06-08 21:27:44.14851+00	2v7rq4cz2qbd	587f0c79-d8f4-4b3b-aa22-6c97eda20c6d
00000000-0000-0000-0000-000000000000	91	sv35ae3a3lmb	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	f	2026-06-08 21:27:44.158096+00	2026-06-08 21:27:44.158096+00	hsrtld6r6vfx	587f0c79-d8f4-4b3b-aa22-6c97eda20c6d
00000000-0000-0000-0000-000000000000	93	7avhip6lfgff	18a69c00-a223-4d66-8d04-81604e78bb64	f	2026-06-08 22:18:14.049583+00	2026-06-08 22:18:14.049583+00	\N	2484727f-c3c4-49f1-b98a-74a9ccbb22f9
00000000-0000-0000-0000-000000000000	92	eazzc37ckzri	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-08 22:17:40.119373+00	2026-06-09 02:11:06.664031+00	\N	b800c021-2134-445d-92a1-4404ebeeab4c
00000000-0000-0000-0000-000000000000	94	h6sn5zcsr3qs	67af4f7e-8864-4397-b69c-d90c3ffd6216	t	2026-06-09 02:11:06.682171+00	2026-06-09 16:26:33.892933+00	eazzc37ckzri	b800c021-2134-445d-92a1-4404ebeeab4c
00000000-0000-0000-0000-000000000000	95	b6bbhcdlhkmr	67af4f7e-8864-4397-b69c-d90c3ffd6216	f	2026-06-09 16:26:33.913979+00	2026-06-09 16:26:33.913979+00	h6sn5zcsr3qs	b800c021-2134-445d-92a1-4404ebeeab4c
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
854b40ce-6bf4-49ae-ae25-49be5fece334	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-04-30 01:44:00.841708+00	2026-04-30 01:44:00.841708+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	186.113.135.0	\N	\N	\N	\N	\N
fc8c8fdc-b114-49da-b670-90dc6a947448	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-01 03:58:24.740453+00	2026-05-01 03:58:24.740453+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
cfcca073-577f-47a1-9924-39d9d4b5e936	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-01 03:58:43.830199+00	2026-05-01 03:58:43.830199+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
ed36ee5d-eec5-4529-8a3f-9e7bb194eaaf	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-01 03:59:18.448453+00	2026-05-01 03:59:18.448453+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
c7929b80-eeb0-46e8-87ea-36770b141453	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-01 04:03:03.540913+00	2026-05-01 04:03:03.540913+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
29814610-2773-484b-98fd-d902a14dad65	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-01 04:04:59.26029+00	2026-05-01 04:04:59.26029+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
44faa15f-138d-4ea1-baa9-87d6a9e64a47	67af4f7e-8864-4397-b69c-d90c3ffd6216	2026-05-01 04:14:17.913539+00	2026-05-01 23:23:28.413561+00	\N	aal1	\N	2026-05-01 23:23:28.413448	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
59e4fc6f-db5a-4b52-a69b-c67bde257083	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-01 23:31:53.573831+00	2026-05-01 23:31:53.573831+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
d65b4f33-c0ab-4364-9a6f-83dca31a6abf	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-01 23:32:13.692384+00	2026-05-01 23:32:13.692384+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
70a5e2af-bdea-4a98-92e5-e8fd865d3988	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-01 23:39:30.139131+00	2026-05-01 23:39:30.139131+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
fd3a1c24-47b8-44d7-a0bb-121acbdc6cd4	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-01 23:53:01.302008+00	2026-05-01 23:53:01.302008+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
d662e3b4-57f2-4bbc-9094-889b310fc207	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 00:08:07.025787+00	2026-05-02 00:08:07.025787+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
29f3b2c5-b5bd-4c4f-b293-1aa689c816c0	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 00:17:43.730189+00	2026-05-02 00:17:43.730189+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
97e1e550-7cf8-4498-88bf-b62f4d631550	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-02 02:47:48.720727+00	2026-05-02 02:47:48.720727+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	181.237.205.203	\N	\N	\N	\N	\N
5f01476e-b315-4df9-8f20-35c473aff97a	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 02:48:16.459517+00	2026-05-02 02:48:16.459517+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	181.237.205.203	\N	\N	\N	\N	\N
2acde7c3-916a-4031-9ffe-be3e911d4538	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 00:31:34.246729+00	2026-05-02 02:56:48.825542+00	\N	aal1	\N	2026-05-02 02:56:48.825435	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
e4e46118-37ba-488a-8e22-d9acc153f77a	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 02:57:06.557458+00	2026-05-02 02:57:06.557458+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
9cc6d4d0-8fb3-4da4-a39e-98c3a7eed4a7	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 02:58:38.608428+00	2026-05-02 02:58:38.608428+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
5a3014e8-c137-480e-ab71-878ce8d2568f	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-01 15:23:07.023932+00	2026-06-01 15:23:07.023932+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
948a1724-081c-4301-a235-c87a4222773c	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 03:09:25.416851+00	2026-05-02 03:09:25.416851+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
4515bb40-8433-4aa2-84f2-cf0e8668e725	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 03:10:58.861391+00	2026-05-02 03:10:58.861391+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
62267bf1-2f22-4d97-8fdb-d1738013e579	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 03:17:53.713401+00	2026-05-02 03:17:53.713401+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
03b885b5-d0a6-4e44-a225-7f9d63c806e8	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-02 03:18:09.681518+00	2026-05-02 03:18:09.681518+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
73b456be-1a73-4f0f-a0b1-849623a7ebc1	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-02 03:20:06.081831+00	2026-05-02 03:20:06.081831+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
6d36c45c-6b7f-4821-8a2c-3e6837bfa477	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-02 03:20:50.320169+00	2026-05-02 03:20:50.320169+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
c65754a0-e482-4663-8672-4a3d274cdc57	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-13 23:14:59.093597+00	2026-05-14 01:11:15.004725+00	\N	aal1	\N	2026-05-14 01:11:15.004617	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
ca4cebe4-fdac-4a26-bbf2-bcddc3452789	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-14 01:11:26.205669+00	2026-05-27 02:36:35.045855+00	\N	aal1	\N	2026-05-27 02:36:35.045756	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
cfe9de1f-f045-49bc-8816-62b97395e314	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-27 02:36:43.822361+00	2026-05-27 02:36:43.822361+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
4796a75e-2ce0-4835-9c86-7eb99aab4805	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-27 02:37:11.170836+00	2026-05-27 02:37:11.170836+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
f2db915a-1dd3-4dc1-b48b-d4aa4a268f3b	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-27 02:37:22.940753+00	2026-05-27 23:33:34.598638+00	\N	aal1	\N	2026-05-27 23:33:34.598472	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
06aa4c79-e535-44d4-8c6e-866d48ebca57	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-27 23:35:04.353473+00	2026-05-28 15:18:52.158183+00	\N	aal1	\N	2026-05-28 15:18:52.158067	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
94d3da27-5f51-4eb9-a81f-ec28b024b849	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-28 15:19:47.018358+00	2026-05-28 15:19:47.018358+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
99e5e8b5-2252-45a4-97ae-f1ba4631acd3	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-05-28 15:20:21.421234+00	2026-05-28 15:20:21.421234+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
d642f222-e601-45a7-a664-f4630eae044c	67af4f7e-8864-4397-b69c-d90c3ffd6216	2026-06-01 22:50:06.981749+00	2026-06-02 01:53:20.506503+00	\N	aal1	\N	2026-06-02 01:53:20.506392	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
13634952-040c-435c-b682-298114526a95	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-06-02 02:09:27.080107+00	2026-06-02 02:09:27.080107+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
ae8efa39-debf-4e96-b935-8bd160ee1d6b	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-01 15:27:55.703322+00	2026-06-01 22:43:57.360814+00	\N	aal1	\N	2026-06-01 22:43:57.359216	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
e0bda8af-e304-4b53-87f2-287758ea7172	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-01 22:49:27.293006+00	2026-06-01 22:49:27.293006+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
3151f1f4-7c39-4d76-8309-99aa84359450	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-28 15:49:50.298951+00	2026-05-31 23:42:56.334921+00	\N	aal1	\N	2026-05-31 23:42:56.334812	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
1315e57f-a969-4505-84e2-490bf0ce8284	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-05-31 23:43:09.17307+00	2026-05-31 23:43:09.17307+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
743a3787-9307-4b90-b80e-053ee6b1da69	23e95308-1699-4b18-8eca-5c8b8ae1a37a	2026-06-02 02:49:00.248332+00	2026-06-02 02:49:00.248332+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
e0e226e5-1021-4737-8471-acf4cdbc1a41	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-02 11:00:34.36933+00	2026-06-02 11:00:34.36933+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	45.127.195.188	\N	\N	\N	\N	\N
a9ae548f-a283-4be2-a4af-0b85e932f253	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-02 02:50:03.583073+00	2026-06-07 16:59:52.597384+00	\N	aal1	\N	2026-06-07 16:59:52.597277	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
64c3967f-92cf-40a6-97b1-a037857dd7b1	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-07 17:06:30.862302+00	2026-06-07 20:59:54.02805+00	\N	aal1	\N	2026-06-07 20:59:54.027946	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
58e808d0-4f2c-4d6b-96fd-fb87e7164633	67af4f7e-8864-4397-b69c-d90c3ffd6216	2026-05-01 23:53:52.299665+00	2026-06-08 03:09:19.877977+00	\N	aal1	\N	2026-06-08 03:09:19.877866	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
91521793-d0cf-445c-8e71-02a73b4ac1a0	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-06-07 21:01:37.901065+00	2026-06-08 03:12:20.163519+00	\N	aal1	\N	2026-06-08 03:12:20.163407	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
73ff0909-9d26-4cee-a898-8e2d1dd9ae68	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 03:51:46.382488+00	2026-06-08 03:51:46.382488+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
9bbac689-9934-4dee-beaf-1a585a7cb07d	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-06-08 04:49:12.75352+00	2026-06-08 16:07:29.915797+00	\N	aal1	\N	2026-06-08 16:07:29.915692	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
aaa25754-212e-41d9-9b5d-f673c68caded	472776d5-15e3-4f7e-befb-ac4c22911ee5	2026-06-08 21:04:39.851948+00	2026-06-08 21:04:39.851948+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 OPR/131.0.0.0	131.0.199.103	\N	\N	\N	\N	\N
587f0c79-d8f4-4b3b-aa22-6c97eda20c6d	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 16:11:24.330674+00	2026-06-08 21:27:44.174858+00	\N	aal1	\N	2026-06-08 21:27:44.174753	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.134.147.62	\N	\N	\N	\N	\N
2484727f-c3c4-49f1-b98a-74a9ccbb22f9	18a69c00-a223-4d66-8d04-81604e78bb64	2026-06-08 22:18:14.048776+00	2026-06-08 22:18:14.048776+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	179.19.137.106	\N	\N	\N	\N	\N
b800c021-2134-445d-92a1-4404ebeeab4c	67af4f7e-8864-4397-b69c-d90c3ffd6216	2026-06-08 22:17:40.113822+00	2026-06-09 16:26:33.936873+00	\N	aal1	\N	2026-06-09 16:26:33.936768	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	181.237.205.203	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	authenticated	authenticated	jorgeandru2007@gmail.com	\N	2026-05-01 03:58:24.733775+00	\N		\N		\N			\N	2026-06-08 16:11:24.329466+00	{"provider": "discord", "providers": ["discord", "google"]}	{"iss": "https://discord.com/api", "sub": "831735406025375745", "name": "l_capitalista#0", "email": "jorgeandru2007@gmail.com", "picture": "https://cdn.discordapp.com/avatars/831735406025375745/73ac71069045600f3d701dd69249d19d.png", "full_name": "l_capitalista", "avatar_url": "https://cdn.discordapp.com/avatars/831735406025375745/73ac71069045600f3d701dd69249d19d.png", "provider_id": "831735406025375745", "custom_claims": {"global_name": "lorito"}, "email_verified": true, "phone_verified": false}	\N	2026-05-01 03:58:24.710712+00	2026-06-08 21:27:44.162816+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	authenticated	authenticated	jorge.ruizf@udea.edu.co	\N	2026-04-30 01:44:00.833388+00	\N		\N		\N			\N	2026-06-08 04:49:12.751597+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "105497616570033014178", "name": "JORGE ANDRÉS RUIZ FLORES", "email": "jorge.ruizf@udea.edu.co", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJMdMRnXXLjvg9rlNHLyJx4XzwHK6kRBpMSTmx5zFAz6Y1rymI=s96-c", "full_name": "JORGE ANDRÉS RUIZ FLORES", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJMdMRnXXLjvg9rlNHLyJx4XzwHK6kRBpMSTmx5zFAz6Y1rymI=s96-c", "provider_id": "105497616570033014178", "custom_claims": {"hd": "udea.edu.co"}, "email_verified": true, "phone_verified": false}	\N	2026-04-30 01:44:00.792173+00	2026-06-08 16:07:29.900234+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	67af4f7e-8864-4397-b69c-d90c3ffd6216	authenticated	authenticated	jorgeandruruiz2007@gmail.com	\N	2026-05-01 04:14:17.906606+00	\N		\N		\N			\N	2026-06-08 22:17:40.111745+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "113872139681872641238", "name": "Jorge Andres Ruiz Flores", "email": "jorgeandruruiz2007@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocI9x3i2rHyoeXtmcZSCLZEo60bGVIoDuyIwF9AKqAbld9nw_j-Q=s96-c", "full_name": "Jorge Andres Ruiz Flores", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocI9x3i2rHyoeXtmcZSCLZEo60bGVIoDuyIwF9AKqAbld9nw_j-Q=s96-c", "provider_id": "113872139681872641238", "email_verified": true, "phone_verified": false}	\N	2026-05-01 04:14:17.876787+00	2026-06-09 16:26:33.923309+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	23e95308-1699-4b18-8eca-5c8b8ae1a37a	authenticated	authenticated	jorgeruizf@iefaz.edu.co	\N	2026-06-02 02:49:00.242467+00	\N		\N		\N			\N	2026-06-02 02:49:00.246422+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "113618264129395912111", "name": "JORGE ANDRES RUIZ FLORES", "email": "jorgeruizf@iefaz.edu.co", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLpnacHBNXi8T9Dl2t1An9GT4udjr4ICURff89n8d0W-S5jWP8=s96-c", "full_name": "JORGE ANDRES RUIZ FLORES", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocLpnacHBNXi8T9Dl2t1An9GT4udjr4ICURff89n8d0W-S5jWP8=s96-c", "provider_id": "113618264129395912111", "custom_claims": {"hd": "iefaz.edu.co"}, "email_verified": true, "phone_verified": false}	\N	2026-06-02 02:49:00.231465+00	2026-06-02 02:49:00.252448+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	472776d5-15e3-4f7e-befb-ac4c22911ee5	authenticated	authenticated	andimois1222@gmail.com	\N	2026-06-08 21:04:39.844719+00	\N		\N		\N			\N	2026-06-08 21:04:39.84973+00	{"provider": "discord", "providers": ["discord"]}	{"iss": "https://discord.com/api", "sub": "1185635433640636540", "name": "anrz68#0", "email": "andimois1222@gmail.com", "picture": "https://cdn.discordapp.com/avatars/1185635433640636540/3a6b1848aa6f4b63dd32872c553646ef.png", "full_name": "anrz68", "avatar_url": "https://cdn.discordapp.com/avatars/1185635433640636540/3a6b1848aa6f4b63dd32872c553646ef.png", "provider_id": "1185635433640636540", "custom_claims": {"global_name": "andru"}, "email_verified": true, "phone_verified": false}	\N	2026-06-08 21:04:39.819841+00	2026-06-08 21:04:39.871917+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	18a69c00-a223-4d66-8d04-81604e78bb64	authenticated	authenticated	jeshuajimenezmarquez@gmail.com	\N	2026-06-08 22:18:14.044674+00	\N		\N		\N			\N	2026-06-08 22:18:14.048684+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "106401334766871683585", "name": "Adriel jeshua Jiménez marquez", "email": "jeshuajimenezmarquez@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocK5fjgBSMRNhuprevlIQorM-UGxygMtatScflaGBvesVEPgSJ9a=s96-c", "full_name": "Adriel jeshua Jiménez marquez", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocK5fjgBSMRNhuprevlIQorM-UGxygMtatScflaGBvesVEPgSJ9a=s96-c", "provider_id": "106401334766871683585", "email_verified": true, "phone_verified": false}	\N	2026-06-08 22:18:14.03327+00	2026-06-08 22:18:14.051193+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
22faca56-6187-4d10-bab8-51f307d7a29e	3a61c41613363f04c3674ace0b8c03e6f3bb30fcb9074ffe6c93e784a9d01056	2026-04-28 01:30:28.976593+00	20260424014139_init	\N	\N	2026-04-28 01:30:28.562548+00	1
4419dfa3-e367-4a41-9f36-229b9e25626d	6472c3ad1b87c17acf77d21ad3df8778c91817567f2e7c2fe6717c87537fdcc8	2026-04-28 01:30:29.565148+00	20260424014320_relations	\N	\N	2026-04-28 01:30:29.137554+00	1
9406b189-a9e0-4c17-a446-2967ddb04b4d	2c43d6913b1287d5775fe8994ef7bb0c0a7d72ce6c85ae709a9540c2a62b14ef	2026-04-28 01:30:30.148759+00	20260424015226_chat_mensaje_imagen_valoracion_notificacion	\N	\N	2026-04-28 01:30:29.725281+00	1
74dbd797-dfa1-497a-b688-52389af38636	1c49afd306a488801386cb39ff6b5ac4e30add2922d171ed60630ea51223a1d4	2026-04-28 01:30:30.87359+00	20260426213039_fix_schema	\N	\N	2026-04-28 01:30:30.30839+00	1
\.


--
-- Data for Name: tbl_carrito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_carrito (id, id_producto, id_usuario) FROM stdin;
12	12	92
13	12	3
14	13	3
17	12	2
\.


--
-- Data for Name: tbl_categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_categoria (id, nombre) FROM stdin;
1	Monedas
4	Skins
3	Cuentas
\.


--
-- Data for Name: tbl_chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_chat (id, fecha, id_venta_x_producto) FROM stdin;
\.


--
-- Data for Name: tbl_imagen_mensaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_imagen_mensaje (id, ruta, fecha, id_tipo_imagen, id_chat) FROM stdin;
\.


--
-- Data for Name: tbl_imagen_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_imagen_producto (id, nombre, ruta, id_producto, id_tipo_imagen) FROM stdin;
3	12.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/12.webp	12	1
6	13.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/13_1780952178499.png	13	1
7	13.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/13_1780952195864.png	13	1
8	13.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/13_1780952200116.png	13	1
9	13.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/13_1780952203802.png	13	1
10	13.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/13_1780952207998.png	13	1
11	14.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/14_1780953252060.webp	14	1
12	15.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/15_1780953808712.webp	15	1
13	15.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/15_1780953830018.png	15	1
14	15.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/15_1780953836560.png	15	1
15	15.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/15_1780953841616.png	15	1
16	15.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/15_1780953845932.png	15	1
17	15.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/15_1780953850298.png	15	1
18	15.png	https://gdwhecwatzmitbfsozbi.supabase.co/storage/v1/object/public/productos/15_1780953854502.png	15	1
\.


--
-- Data for Name: tbl_mensaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_mensaje (id, fecha, contenido, id_chat, id_usuario) FROM stdin;
\.


--
-- Data for Name: tbl_metodo_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_metodo_pago (id, nombre, id_pais) FROM stdin;
1	Nequi	1
2	Yape	2
3	Binance	3
\.


--
-- Data for Name: tbl_notificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_notificacion (id, fecha_notificado, descripcion, id_producto_deseado) FROM stdin;
\.


--
-- Data for Name: tbl_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_pais (id, nombre) FROM stdin;
1	Colombia
2	Perú
3	Internacional
\.


--
-- Data for Name: tbl_precio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_precio (id, precio, id_pais, id_producto) FROM stdin;
6	170.00	2	13
5	185000.00	1	13
7	50.00	3	13
2	53.00	2	12
3	54000.00	1	12
4	15.00	3	12
8	58000.00	1	14
9	56.00	2	14
10	16.00	3	14
12	450000.00	1	15
11	125.00	3	15
13	440.00	2	15
\.


--
-- Data for Name: tbl_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_producto (id, nombre, descripcion, id_vendedor, id_pais, id_categoria, id_videojuego) FROM stdin;
13	Cuenta Minecraft [MVP+]	Rango Mvp+ En Hypixel | Rango Mercurio En UniversoCraft | 51 Cosmeticos De Lunar Client (~558 USD) | Cosmeticos Reparados De UniversoCraft	3	1	3	3
12	Cuenta Minecraft [MVP+]	Rango MVP+ en Hypixel | 5 cosmeticos en Lunar Client	3	1	3	3
14	Cuenta Minecraft [MVP+]	Rango MVP+ en Hypixel | 5 Cosmeticos en Lunar Client	3	1	3	3
15	Cuenta Minecraft [Saturno]	Rango MVP+ en Hypixel | Rango Saturno en UniversoCraft | ¡201 COSMETICOS EN LUNAR CLIENT (~$1842)!	3	1	3	3
\.


--
-- Data for Name: tbl_producto_deseado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_producto_deseado (id, precio_objetivo, id_producto, id_usuario) FROM stdin;
\.


--
-- Data for Name: tbl_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_rol (id, nombre) FROM stdin;
1	Usuario
3	Administrador
\.


--
-- Data for Name: tbl_tipo_imagen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_tipo_imagen (id, nombre) FROM stdin;
1	png
2	jpg
3	jpeg
4	gif
5	avif
\.


--
-- Data for Name: tbl_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_usuario (id, nombre, usuario, ventas, correo, id_pais, id_rol, id_metodo_pago_fav) FROM stdin;
92	JORGE ANDRÉS RUIZ FLORES	jorge.ruizf	0	jorge.ruizf@udea.edu.co	3	1	1
3	Jorge Ruiz	jorgeandru2007	0	jorgeandru2007@gmail.com	1	3	1
2	Jorge Andres Ruiz Flores	jorgeandruruiz2007	0	jorgeandruruiz2007@gmail.com	1	1	1
\.


--
-- Data for Name: tbl_valoracion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_valoracion (id, fecha, puntaje, id_venta_x_producto) FROM stdin;
\.


--
-- Data for Name: tbl_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_venta (id, total, fecha, id_usuario, id_metodo_pago) FROM stdin;
\.


--
-- Data for Name: tbl_venta_x_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_venta_x_producto (id, id_producto, id_venta, cantidad, precio) FROM stdin;
\.


--
-- Data for Name: tbl_videojuego; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_videojuego (id, nombre) FROM stdin;
3	Minecraft
4	League of Legends
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-04-27 22:27:27
20211116045059	2026-04-27 22:27:27
20211116050929	2026-04-27 22:27:27
20211116051442	2026-04-27 22:27:27
20211116212300	2026-04-27 22:27:27
20211116213355	2026-04-27 22:27:27
20211116213934	2026-04-27 22:27:27
20211116214523	2026-04-27 22:27:27
20211122062447	2026-04-27 22:27:27
20211124070109	2026-04-27 22:27:27
20211202204204	2026-04-27 22:27:27
20211202204605	2026-04-27 22:27:27
20211210212804	2026-04-27 22:27:27
20211228014915	2026-04-27 22:27:27
20220107221237	2026-04-27 22:27:27
20220228202821	2026-04-27 22:27:27
20220312004840	2026-04-27 22:27:27
20220603231003	2026-04-27 22:27:27
20220603232444	2026-04-27 22:27:27
20220615214548	2026-04-27 22:27:28
20220712093339	2026-04-27 22:27:28
20220908172859	2026-04-27 22:27:28
20220916233421	2026-04-27 22:27:28
20230119133233	2026-04-28 00:55:37
20230128025114	2026-04-28 00:55:37
20230128025212	2026-04-28 00:55:37
20230227211149	2026-04-28 00:55:37
20230228184745	2026-04-28 00:55:37
20230308225145	2026-04-28 00:55:37
20230328144023	2026-04-28 00:55:37
20231018144023	2026-04-28 00:55:37
20231204144023	2026-04-28 00:55:37
20231204144024	2026-04-28 00:55:37
20231204144025	2026-04-28 00:55:37
20240108234812	2026-04-28 00:55:37
20240109165339	2026-04-28 00:55:37
20240227174441	2026-04-28 00:55:37
20240311171622	2026-04-28 00:55:37
20240321100241	2026-04-28 00:55:37
20240401105812	2026-04-28 00:55:37
20240418121054	2026-04-28 00:55:37
20240523004032	2026-04-28 00:55:37
20240618124746	2026-04-28 00:55:38
20240801235015	2026-04-28 00:55:38
20240805133720	2026-04-28 00:55:38
20240827160934	2026-04-28 00:55:38
20240919163303	2026-04-28 00:55:38
20240919163305	2026-04-28 00:55:38
20241019105805	2026-04-28 00:55:38
20241030150047	2026-04-28 00:55:38
20241108114728	2026-04-28 00:55:38
20241121104152	2026-04-28 00:55:38
20241130184212	2026-04-28 00:55:38
20241220035512	2026-04-28 00:55:38
20241220123912	2026-04-28 00:55:38
20241224161212	2026-04-28 00:55:38
20250107150512	2026-04-28 00:55:38
20250110162412	2026-04-28 00:55:38
20250123174212	2026-04-28 00:55:38
20250128220012	2026-04-28 00:55:38
20250506224012	2026-04-28 00:55:38
20250523164012	2026-04-28 00:55:38
20250714121412	2026-04-28 00:55:38
20250905041441	2026-04-28 00:55:38
20251103001201	2026-04-28 00:55:38
20251120212548	2026-04-28 00:55:38
20251120215549	2026-04-28 00:55:38
20260218120000	2026-04-28 00:55:38
20260326120000	2026-04-28 00:55:38
20260514120000	2026-06-07 16:06:37
20260527120000	2026-06-07 16:06:37
20260528120000	2026-06-07 16:06:37
20260603120000	2026-06-07 16:06:37
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
productos	productos	\N	2026-06-02 22:39:46.388792+00	2026-06-02 22:39:46.388792+00	t	f	\N	\N	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-04-27 22:28:04.669392
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-04-27 22:28:04.701028
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-04-27 22:28:04.703049
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-04-27 22:28:04.722097
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-04-27 22:28:04.732188
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-04-27 22:28:04.734927
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-04-27 22:28:04.737465
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-04-27 22:28:04.740547
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-04-27 22:28:04.742718
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-04-27 22:28:04.745162
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-04-27 22:28:04.74886
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-04-27 22:28:04.751183
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-04-27 22:28:04.753848
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-04-27 22:28:04.756098
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-04-27 22:28:04.759112
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-04-27 22:28:04.781983
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-04-27 22:28:04.784404
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-04-27 22:28:04.786388
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-04-27 22:28:04.788898
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-04-27 22:28:04.792551
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-04-27 22:28:04.795018
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-04-27 22:28:04.798648
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-04-27 22:28:04.810308
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-04-27 22:28:04.8173
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-04-27 22:28:04.819675
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-04-27 22:28:04.821771
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-04-27 22:28:04.824264
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-04-27 22:28:04.826139
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-04-27 22:28:04.828056
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-04-27 22:28:04.829945
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-04-27 22:28:04.831721
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-04-27 22:28:04.833413
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-04-27 22:28:04.83529
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-04-27 22:28:04.837174
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-04-27 22:28:04.838949
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-04-27 22:28:04.841544
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-04-27 22:28:04.843275
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-04-27 22:28:04.845261
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-04-27 22:28:04.848046
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-04-27 22:28:04.862981
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-04-27 22:28:04.865011
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-04-27 22:28:04.866756
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-04-27 22:28:04.868633
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-04-27 22:28:04.871364
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-04-27 22:28:04.873505
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-04-27 22:28:04.87617
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-04-27 22:28:04.885258
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-04-27 22:28:04.888204
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-04-27 22:28:04.890199
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-04-27 22:28:04.906829
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-04-27 22:28:04.909794
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-04-27 22:28:04.993754
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-04-27 22:28:04.994851
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-04-27 22:28:05.003696
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-04-27 22:28:05.005541
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-04-27 22:28:05.006506
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-04-27 22:28:05.013852
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-04-27 22:28:05.016446
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-04-27 22:28:05.009507
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-04-30 04:49:14.785912
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-04-30 04:49:14.801607
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
d64ba4fe-2eec-4d46-8143-0f0687072358	productos	9.webp	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-02 23:44:29.880311+00	2026-06-02 23:44:29.880311+00	2026-06-02 23:44:29.880311+00	{"eTag": "\\"12d0cef2a412261b54a13fe08de78086\\"", "size": 50980, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-02T23:44:30.000Z", "contentLength": 50980, "httpStatusCode": 200}	5a31f8f9-8479-49de-8b95-b615c360863a	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
9f471fb7-c922-4d3b-8271-7e9adac1c4ca	productos	10.webp	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-03 00:47:25.217921+00	2026-06-03 00:47:25.217921+00	2026-06-03 00:47:25.217921+00	{"eTag": "\\"12d0cef2a412261b54a13fe08de78086\\"", "size": 50980, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-03T00:47:26.000Z", "contentLength": 50980, "httpStatusCode": 200}	ef15de81-c877-4992-9c0f-0c77f72fce5b	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
729f10c2-ff0b-4a89-9a32-b334bbccee50	productos	11.webp	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-07 17:02:54.689199+00	2026-06-07 17:02:54.689199+00	2026-06-07 17:02:54.689199+00	{"eTag": "\\"2460ee725f0517462fbb252b250634cc\\"", "size": 275992, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-07T17:02:55.000Z", "contentLength": 275992, "httpStatusCode": 200}	7a179b2e-6e56-4cd5-9325-fcb07455ef81	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
ac9d1935-8a79-4b28-8f47-570eba10138d	productos	12.webp	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-06-07 21:42:00.214669+00	2026-06-07 21:42:00.214669+00	2026-06-07 21:42:00.214669+00	{"eTag": "\\"2460ee725f0517462fbb252b250634cc\\"", "size": 275992, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-07T21:42:01.000Z", "contentLength": 275992, "httpStatusCode": 200}	bc747307-f8a5-49cc-bbfa-c2a464f820e0	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	{}
c305f431-49c6-42ea-ad4f-c06eb7cdec20	productos	12_1780874322205.webp	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	2026-06-07 23:18:42.93764+00	2026-06-07 23:18:42.93764+00	2026-06-07 23:18:42.93764+00	{"eTag": "\\"6ebbf90b6c37fa81dca20d9f82721e41\\"", "size": 179376, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-07T23:18:43.000Z", "contentLength": 179376, "httpStatusCode": 200}	a81388c2-cebd-4552-bb09-1a4ab25aef37	3dc33d7d-0946-4edb-8877-a04ac2d4d6ea	{}
84ce777f-992a-4284-a95f-94479ee65142	productos	12_1780950699970.webp	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 20:31:40.920325+00	2026-06-08 20:31:40.920325+00	2026-06-08 20:31:40.920325+00	{"eTag": "\\"6ebbf90b6c37fa81dca20d9f82721e41\\"", "size": 179376, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T20:31:41.000Z", "contentLength": 179376, "httpStatusCode": 200}	52392b1a-c307-4d33-aa20-8c58053c8238	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
a0dfbb50-202b-4a96-a985-cab1e96e3329	productos	13_1780952178499.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 20:56:19.4796+00	2026-06-08 20:56:19.4796+00	2026-06-08 20:56:19.4796+00	{"eTag": "\\"30c4921eb58b0dfeed2cb80cfb4739c8\\"", "size": 713923, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T20:56:20.000Z", "contentLength": 713923, "httpStatusCode": 200}	eed589d3-f222-4b36-8d81-33ab2412903e	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
dfdd016b-d9b7-48ab-9e8a-f064eb68276b	productos	13_1780952195864.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 20:56:36.521253+00	2026-06-08 20:56:36.521253+00	2026-06-08 20:56:36.521253+00	{"eTag": "\\"10343f9d6f8769771d09a6bdec090103\\"", "size": 564122, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T20:56:37.000Z", "contentLength": 564122, "httpStatusCode": 200}	88033942-22b1-4247-8b4e-594f448bbf47	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
b4d62b71-3281-4d5f-b228-3b74ea46d4ba	productos	13_1780952200116.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 20:56:41.018995+00	2026-06-08 20:56:41.018995+00	2026-06-08 20:56:41.018995+00	{"eTag": "\\"a960ba8c2d74692fade7e7faffbc08dd\\"", "size": 464177, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T20:56:41.000Z", "contentLength": 464177, "httpStatusCode": 200}	fea1953c-e71f-4844-969c-1804a6377a42	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
7713a92b-e8d9-4180-a37d-54be31f327b1	productos	13_1780952203802.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 20:56:44.584036+00	2026-06-08 20:56:44.584036+00	2026-06-08 20:56:44.584036+00	{"eTag": "\\"2885c6eabaa76300f765eb0d986024b7\\"", "size": 480253, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T20:56:45.000Z", "contentLength": 480253, "httpStatusCode": 200}	bee9c646-4e42-426f-b813-b3ea09af6cec	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
96f58769-d55b-4acc-b4e9-a41e1f222848	productos	13_1780952207998.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 20:56:48.651454+00	2026-06-08 20:56:48.651454+00	2026-06-08 20:56:48.651454+00	{"eTag": "\\"14c41ff00e99ded70deb147924ec7430\\"", "size": 470051, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T20:56:49.000Z", "contentLength": 470051, "httpStatusCode": 200}	40689b78-9dd2-470f-a4a1-e0226acb56e6	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
56cb356a-75ea-4a7e-9d69-5976cbfaca55	productos	14_1780953252060.webp	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:14:13.50653+00	2026-06-08 21:14:13.50653+00	2026-06-08 21:14:13.50653+00	{"eTag": "\\"6ebbf90b6c37fa81dca20d9f82721e41\\"", "size": 179376, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:14:14.000Z", "contentLength": 179376, "httpStatusCode": 200}	23e332a1-99be-4b51-b673-c88972977cdc	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
1c4bec9e-98e9-477a-8d83-8b13249f5f0d	productos	15_1780953808712.webp	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:23:29.605316+00	2026-06-08 21:23:29.605316+00	2026-06-08 21:23:29.605316+00	{"eTag": "\\"ede13e0db2d3e9f3d0d5cdb51eeec8d4\\"", "size": 397352, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:23:30.000Z", "contentLength": 397352, "httpStatusCode": 200}	6ae7ab22-9059-416a-92cb-9b7c47ee24ce	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
317f5ef3-9f3d-48fa-be82-1e020da64dc2	productos	15_1780953830018.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:23:50.804286+00	2026-06-08 21:23:50.804286+00	2026-06-08 21:23:50.804286+00	{"eTag": "\\"d5a3637603c50ddc79d05f5a21a46f45\\"", "size": 439841, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:23:51.000Z", "contentLength": 439841, "httpStatusCode": 200}	f8518ecd-fbd8-4e81-ac0c-21594dbeedf4	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
3fdbb0c9-6f02-4d25-9d74-a38acf082462	productos	15_1780953836560.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:23:57.386847+00	2026-06-08 21:23:57.386847+00	2026-06-08 21:23:57.386847+00	{"eTag": "\\"a11bd4d91222e8398c72d940a143ee4a\\"", "size": 443664, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:23:58.000Z", "contentLength": 443664, "httpStatusCode": 200}	997942b8-5166-4e45-a590-c05ab7204657	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
3366bad3-8a64-4943-b848-46dbdc346709	productos	15_1780953841616.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:24:02.55306+00	2026-06-08 21:24:02.55306+00	2026-06-08 21:24:02.55306+00	{"eTag": "\\"56c572116bca8a4378b2d688417604ad\\"", "size": 431783, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:24:03.000Z", "contentLength": 431783, "httpStatusCode": 200}	1d9f1e94-95dc-4492-9544-498c8587f29c	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
0f029b23-6ebd-4631-90ef-f46dfb4fc031	productos	15_1780953845932.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:24:06.937433+00	2026-06-08 21:24:06.937433+00	2026-06-08 21:24:06.937433+00	{"eTag": "\\"217030491cc4f19d5e2435944b490bde\\"", "size": 412768, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:24:07.000Z", "contentLength": 412768, "httpStatusCode": 200}	245cd5ec-7efc-40c7-9349-e16d22c1c307	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
8f58d762-dad8-4a37-b62b-34d60b76d2ea	productos	15_1780953850298.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:24:11.254053+00	2026-06-08 21:24:11.254053+00	2026-06-08 21:24:11.254053+00	{"eTag": "\\"f4e980fd8fc448291222e77f6cc4af05\\"", "size": 360207, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:24:12.000Z", "contentLength": 360207, "httpStatusCode": 200}	dae134fb-1d43-4d17-972b-9c0d31e093b0	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
78a788ad-02b8-45d3-bf12-2f277e38eb0f	productos	15_1780953854502.png	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	2026-06-08 21:24:15.647069+00	2026-06-08 21:24:15.647069+00	2026-06-08 21:24:15.647069+00	{"eTag": "\\"141150fcd7f3b7814339b272545a045f\\"", "size": 411251, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-08T21:24:16.000Z", "contentLength": 411251, "httpStatusCode": 200}	1600eaaa-1991-49bc-bbfe-4b4fea9e776a	91fd8ec4-a095-4df2-a1dc-06166de2cbc0	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 95, true);


--
-- Name: tbl_carrito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_carrito_id_seq', 17, true);


--
-- Name: tbl_categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_categoria_id_seq', 4, true);


--
-- Name: tbl_chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_chat_id_seq', 1, false);


--
-- Name: tbl_imagen_mensaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_imagen_mensaje_id_seq', 1, false);


--
-- Name: tbl_imagen_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_imagen_producto_id_seq', 18, true);


--
-- Name: tbl_mensaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_mensaje_id_seq', 1, false);


--
-- Name: tbl_metodo_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_metodo_pago_id_seq', 3, true);


--
-- Name: tbl_notificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_notificacion_id_seq', 3, true);


--
-- Name: tbl_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_pais_id_seq', 3, true);


--
-- Name: tbl_precio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_precio_id_seq', 13, true);


--
-- Name: tbl_producto_deseado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_producto_deseado_id_seq', 4, true);


--
-- Name: tbl_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_producto_id_seq', 15, true);


--
-- Name: tbl_rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_rol_id_seq', 3, true);


--
-- Name: tbl_tipo_imagen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_tipo_imagen_id_seq', 5, true);


--
-- Name: tbl_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_usuario_id_seq', 101, true);


--
-- Name: tbl_valoracion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_valoracion_id_seq', 1, false);


--
-- Name: tbl_venta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_venta_id_seq', 1, false);


--
-- Name: tbl_venta_x_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_venta_x_producto_id_seq', 1, false);


--
-- Name: tbl_videojuego_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_videojuego_id_seq', 4, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: tbl_carrito tbl_carrito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_carrito
    ADD CONSTRAINT tbl_carrito_pkey PRIMARY KEY (id);


--
-- Name: tbl_categoria tbl_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_categoria
    ADD CONSTRAINT tbl_categoria_pkey PRIMARY KEY (id);


--
-- Name: tbl_chat tbl_chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_chat
    ADD CONSTRAINT tbl_chat_pkey PRIMARY KEY (id);


--
-- Name: tbl_imagen_mensaje tbl_imagen_mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_mensaje
    ADD CONSTRAINT tbl_imagen_mensaje_pkey PRIMARY KEY (id);


--
-- Name: tbl_imagen_producto tbl_imagen_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_producto
    ADD CONSTRAINT tbl_imagen_producto_pkey PRIMARY KEY (id);


--
-- Name: tbl_mensaje tbl_mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_mensaje
    ADD CONSTRAINT tbl_mensaje_pkey PRIMARY KEY (id);


--
-- Name: tbl_metodo_pago tbl_metodo_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_metodo_pago
    ADD CONSTRAINT tbl_metodo_pago_pkey PRIMARY KEY (id);


--
-- Name: tbl_notificacion tbl_notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_notificacion
    ADD CONSTRAINT tbl_notificacion_pkey PRIMARY KEY (id);


--
-- Name: tbl_pais tbl_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_pais
    ADD CONSTRAINT tbl_pais_pkey PRIMARY KEY (id);


--
-- Name: tbl_precio tbl_precio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_precio
    ADD CONSTRAINT tbl_precio_pkey PRIMARY KEY (id);


--
-- Name: tbl_producto_deseado tbl_producto_deseado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto_deseado
    ADD CONSTRAINT tbl_producto_deseado_pkey PRIMARY KEY (id);


--
-- Name: tbl_producto tbl_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_pkey PRIMARY KEY (id);


--
-- Name: tbl_rol tbl_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_rol
    ADD CONSTRAINT tbl_rol_pkey PRIMARY KEY (id);


--
-- Name: tbl_tipo_imagen tbl_tipo_imagen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_tipo_imagen
    ADD CONSTRAINT tbl_tipo_imagen_pkey PRIMARY KEY (id);


--
-- Name: tbl_usuario tbl_usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_correo_key UNIQUE (correo);


--
-- Name: tbl_usuario tbl_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_pkey PRIMARY KEY (id);


--
-- Name: tbl_valoracion tbl_valoracion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_valoracion
    ADD CONSTRAINT tbl_valoracion_pkey PRIMARY KEY (id);


--
-- Name: tbl_venta tbl_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta
    ADD CONSTRAINT tbl_venta_pkey PRIMARY KEY (id);


--
-- Name: tbl_venta_x_producto tbl_venta_x_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta_x_producto
    ADD CONSTRAINT tbl_venta_x_producto_pkey PRIMARY KEY (id);


--
-- Name: tbl_videojuego tbl_videojuego_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_videojuego
    ADD CONSTRAINT tbl_videojuego_pkey PRIMARY KEY (id);


--
-- Name: messages messages_payload_exclusive; Type: CHECK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages
    ADD CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL))) NOT VALID;


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: tbl_chat_id_venta_x_producto_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tbl_chat_id_venta_x_producto_key ON public.tbl_chat USING btree (id_venta_x_producto);


--
-- Name: tbl_valoracion_id_venta_x_producto_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tbl_valoracion_id_venta_x_producto_key ON public.tbl_valoracion USING btree (id_venta_x_producto);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_selec; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_selec ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter, COALESCE(selected_columns, '{}'::text[]));


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: tbl_carrito tbl_carrito_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_carrito
    ADD CONSTRAINT tbl_carrito_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_carrito tbl_carrito_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_carrito
    ADD CONSTRAINT tbl_carrito_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_chat tbl_chat_id_venta_x_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_chat
    ADD CONSTRAINT tbl_chat_id_venta_x_producto_fkey FOREIGN KEY (id_venta_x_producto) REFERENCES public.tbl_venta_x_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_mensaje tbl_imagen_mensaje_id_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_mensaje
    ADD CONSTRAINT tbl_imagen_mensaje_id_chat_fkey FOREIGN KEY (id_chat) REFERENCES public.tbl_chat(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_mensaje tbl_imagen_mensaje_id_tipo_imagen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_mensaje
    ADD CONSTRAINT tbl_imagen_mensaje_id_tipo_imagen_fkey FOREIGN KEY (id_tipo_imagen) REFERENCES public.tbl_tipo_imagen(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_producto tbl_imagen_producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_producto
    ADD CONSTRAINT tbl_imagen_producto_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_producto tbl_imagen_producto_id_tipo_imagen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_imagen_producto
    ADD CONSTRAINT tbl_imagen_producto_id_tipo_imagen_fkey FOREIGN KEY (id_tipo_imagen) REFERENCES public.tbl_tipo_imagen(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_mensaje tbl_mensaje_id_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_mensaje
    ADD CONSTRAINT tbl_mensaje_id_chat_fkey FOREIGN KEY (id_chat) REFERENCES public.tbl_chat(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_mensaje tbl_mensaje_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_mensaje
    ADD CONSTRAINT tbl_mensaje_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_metodo_pago tbl_metodo_pago_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_metodo_pago
    ADD CONSTRAINT tbl_metodo_pago_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_notificacion tbl_notificacion_id_producto_deseado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_notificacion
    ADD CONSTRAINT tbl_notificacion_id_producto_deseado_fkey FOREIGN KEY (id_producto_deseado) REFERENCES public.tbl_producto_deseado(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_precio tbl_precio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_precio
    ADD CONSTRAINT tbl_precio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_precio tbl_precio_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_precio
    ADD CONSTRAINT tbl_precio_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto_deseado tbl_producto_deseado_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto_deseado
    ADD CONSTRAINT tbl_producto_deseado_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto_deseado tbl_producto_deseado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto_deseado
    ADD CONSTRAINT tbl_producto_deseado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.tbl_categoria(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_vendedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_vendedor_fkey FOREIGN KEY (id_vendedor) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_videojuego_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES public.tbl_videojuego(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_usuario tbl_usuario_id_metodo_pago_fav_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_id_metodo_pago_fav_fkey FOREIGN KEY (id_metodo_pago_fav) REFERENCES public.tbl_metodo_pago(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_usuario tbl_usuario_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_usuario tbl_usuario_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.tbl_rol(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_valoracion tbl_valoracion_id_venta_x_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_valoracion
    ADD CONSTRAINT tbl_valoracion_id_venta_x_producto_fkey FOREIGN KEY (id_venta_x_producto) REFERENCES public.tbl_venta_x_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta tbl_venta_id_metodo_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta
    ADD CONSTRAINT tbl_venta_id_metodo_pago_fkey FOREIGN KEY (id_metodo_pago) REFERENCES public.tbl_metodo_pago(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta tbl_venta_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta
    ADD CONSTRAINT tbl_venta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta_x_producto tbl_venta_x_producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta_x_producto
    ADD CONSTRAINT tbl_venta_x_producto_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta_x_producto tbl_venta_x_producto_id_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_venta_x_producto
    ADD CONSTRAINT tbl_venta_x_producto_id_venta_fkey FOREIGN KEY (id_venta) REFERENCES public.tbl_venta(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects allow_public_read 1hmvp5f_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow_public_read 1hmvp5f_0" ON storage.objects FOR SELECT TO authenticated, anon USING ((bucket_id = 'productos'::text));


--
-- Name: objects allow_public_upload 1hmvp5f_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow_public_upload 1hmvp5f_0" ON storage.objects FOR INSERT TO authenticated, anon WITH CHECK ((bucket_id = 'productos'::text));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION send_binary(payload bytea, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION wal2json_escape_identifier(name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO postgres;
GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict fVPexQ4S6FAC1kDeUiFfZ35y3YAOe2y4Vyd7jzY6Jbmxnt8AphAJ4MmdgWW2cdd

