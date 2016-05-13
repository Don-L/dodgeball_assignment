DROP TABLE matches;
DROP TABLE teams;
-- DROP TABLE leagues;


-- CREATE TABLE leagues (

--   id serial4 primary key,
--   name VARCHAR(255)

-- );

CREATE TABLE teams (

  id serial4 primary key,
  -- league_id INT4 references leagues(id) ON DELETE CASCADE,
  name VARCHAR(255),
  matches_played INT4,
  points INT4,

);


CREATE TABLE matches (

  id serial4 primary key,
  home_id INT4 references teams(id) ON DELETE CASCADE,
  away_id INT4 references teams(id) ON DELETE CASCADE,
  result INT4

);