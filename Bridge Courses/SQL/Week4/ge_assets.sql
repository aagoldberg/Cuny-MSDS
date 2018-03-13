-- ge_assets.sql
-- information sourced from: http://en.wikipedia.org/wiki/List_of_assets_owned_by_General_Electric

DROP TABLE IF EXISTS companies;

CREATE TABLE companies (
  company_id int PRIMARY KEY,
  company_name varchar NOT NULL,
  parent_id int NULL
);

INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 1, 'General Electric', NULL);
INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 2, 'GE Capital', 1);
INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 3, 'GE Energy Management', 1);
INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 4, 'GE Oil and Gas', 1);
INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 5, 'GE Capital Aviation Services', 2);
INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 6, 'GE Energy Financial Services', 2);
INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 7, 'GE Power Electronics', 3);
INSERT INTO companies ( company_id, company_name, parent_id ) VALUES ( 8, 'GE Power Components', 3);

SELECT parent.company_name AS parent, subsidiary.company_name AS subsidiary
  FROM companies parent
       JOIN companies subsidiary
       ON subsidiary.parent_id = parent.company_id
ORDER BY parent, subsidiary;
       


