create database Fifa_Worldcup;
use fifa_worldcup;
 select * from worldcups;
 
 -- SHOWING THE DESCRIPTION ABOUT THE DATA--
 DESC worldcups;
 DESC worldcup_groups;
 DESC worldcup_squads;
 DESC worldcup_matches;
 
 -- ANALYZING WITH PARTICULAR TABLE DATA--
 SELECT * FROM WORLDCUPS;
 SELECT * FROM worldcup_groups;
 SELECT * FROM worldcup_squads;
 SELECT * FROM worldcup_matches;
 
                                            -- TOTAL NUMBER OF ROWS--
SELECT COUNT(*) AS TOTAL_NO_OF_ROWS FROM WORLDCUPS;
-- TOTAL NUMBER OF ROWS
SELECT COUNT(*) AS TOTAL_NO_OF_ROWS FROM worldcup_groups;




                                            -- TOTAL NO OF COLOUMNS--
SELECT COUNT(*) AS NUMBER_OF_COLUMNS 
FROM INFORMATION_SCHEMA. COLUMNS 
WHERE table_schema = 'fifa_worldcup' AND table_name = 'WORLDCUP_MATCHES'; 


-- RETRIVE THE TOTAL NO OF TEAMS PLAYING FROM WORLDCUP_SQUADS TABLE

select count(team)
 as Total_No_Of_Teams
 from worldcup_squads;


                                            -- TO REMOVE DUPICATE VALUE WE USE DISTINCT FN--
 -- GIVE ME TEAM NAMES PLAYING FOR WORLDCUP FROM WORLDCUP_SQUAD TABLE AS IT CONTAINTS DUPLICATES OF TEAM NAMES  
 
 SELECT DISTINCT(TEAM)
 AS TEAMS_PLAYING 
 FROM WORLDCUP_SQUADS;
                                            
                                            
-- AS BELOW QUERY GIVES THE TOTAL NO OF TEAMS PLAYING WITHOUT DUPLICATES TO OVERCOME

select count(DISTINCT(TEAM)) 
as Total_No_Of_Teams
 from worldcup_squads;



                                         -- LIMIT & ORDERBY CLAUSE--
-- TO SEE THE FIRST 10 RECORDS OF WORLDCUP TABLE
SELECT * FROM worldcups  LIMIT 10;

-- TO SEE THE LAST 5 RECORDS OF WORLDCUP TABLE

SELECT * FROM WORLDCUPS ORDER BY YEAR DESC LIMIT 5;

-- GIVE ME THE TOP 1ST COUNTRY DETAILS WITH MAX GOALS SCORED
 SELECT * FROM worldcups
 ORDER BY
 Goals_Scored DESC LIMIT 1;
 
 
 -- GIVE ME THE 2ND TOP COUNTRY WITH FIFA RANKING
 SELECT * FROM worldcup_groups 
 order by fifa_ranking
 desc limit 1,1;
 
 
 
 
                                           -- BASED ON SELECTED COLOUMN VIEWS--
 -- GIVE THE DETAILS OF FIRST 6 COLOUMN WITH RESPECT TO TOP 5 CAPS RECORDS FROM WORLDCUP_SQUADS TABLE
SELECT ID,team,Position,player,age,caps FROM worldcup_squads ORDER BY caps DESC LIMIT 5; 



                                                      -- CASE FN--
-- CATEGORIZE COLOUMN GOALS_SCORED FROM WORLDCUPS TABLE BASED ON NO OF GOALS SCORES USING CASE FUNCTION 

SELECT YEAR,HOST_COUNTRY,WINNER,GOALS_SCORED,
CASE
WHEN  Goals_Scored < 100 THEN 'Low Scoring'
        WHEN Goals_Scored BETWEEN 100 AND 150 THEN 'Moderate Scoring'
        WHEN Goals_Scored > 150 THEN 'High Scoring'
        ELSE 'Unknown Category'
    END AS Scoring_Category
FROM worldcups;




                                        -- DATA AGGREGATION--
-- LIST THE NO OF TEAMS IN FIFAWORLDCUP 2022 WITH OR HAD FIFA RANKING WITH 10 OR LESS
SELECT COUNT(*) AS Top_10_Teams 
FROM worldcup_groups 
WHERE FIFA_Ranking <= 10;


-- WHICH WORLDCUP HAD THE HIGHEST NUMBER OF MATCHES PLAYED
SELECT YEAR,MATCHES_PLAYED
FROM worldcups
WHERE MATCHES_PLAYED = (SELECT MAX(MATCHES_PLAYED)FROM WORLDCUPS);


-- TOTAL NUMBER OF MATCHES PLAYED ACROSS ALL THE WORLDCUPS
SELECT SUM(MATCHES_PLAYED) AS TOTAL_MATCHES
FROM WORLDCUPS;


-- ACQUIRE THE ROUND OF AVERAGE OF QUALIFIED TEAMS FROM TABLE
SELECT 
    ROUND(AVG(QUALIFIED_TEAMS)) AS AVERAGE_QUALIFIED_TEAMS 
FROM 
    worldCUPS;


-- WHICH HOME_TEAM LIES IN THE NOV 2022
SELECT YEAR,DATE,HOME_TEAM 
FROM worldcup_matches
 WHERE EXTRACT(MONTH FROM DATE)=11;

 
 -- List all teams that either won the World Cup or were part of the 2022 World Cup groups
 SELECT 
    Winner AS Team 
FROM 
    worldcups
UNION
SELECT Team 
FROM worldcup_groups;

 -- LIST ALL YEAR OF WHERE WORLDCUP WAS HOSTED OR WON BY BRAZIL 
 SELECT Year 
FROM worldcups 
WHERE Host_Country = 'Brazil'
UNION
SELECT Year 
FROM worldcups 
WHERE 
    Winner = 'Brazil';


                                                     -- LIKE / WILDCARD OPERATOR--
-- FIND THE PLAYER FROM WORLDCUP_SQUADS WHERE POSTION OF PLAYER IS GOALKEEPER AND PLAYER NAME STARTS WITH A
 SELECT COUNT(DISTINCT(PLAYER)) 
FROM worldcup_squads 
WHERE POSITION ='GOALKEEPER'AND PLAYER LIKE '%A';
 
 
 
                                                               -- JOINS--
-- FIND THE FIFA RANKING OF WINNING TEAM OF EACH WORLDCUP
SELECT 
    wc.Year, 
    wc.Winner, 
    g.FIFA_Ranking 
FROM 
    worldcups wc
INNER JOIN 
    worldcup_groups g ON wc.Winner = g.Team;
    
    -- LEFT JOIN
    -- Retrieve all matches along with any corresponding squad information, including matches that might not have any squads.
    SELECT 
    m.ID, 
    m.Date, 
    m.Stage, 
    m.Home_Team, 
    m.Away_Team, 
    s.Team, 
    s.Position, 
    s.Player, 
    s.Club
FROM 
    worldcup_matches AS m
LEFT JOIN 
    worldcup_squads AS s 
ON 
    m.ID = s.ID;
    
    -- RIGHT JOIN
    -- Retrieve all squads and the corresponding match details, including squads that might not be linked to any match.
    SELECT 
    s.ID, 
    s.Team, 
    s.Player, 
    s.Position, 
    s.Club, 
    m.Date, 
    m.Stage, 
    m.Home_Team, 
    m.Away_Team
FROM 
    worldcup_squads AS s
RIGHT JOIN 
    worldcup_matches AS m 
ON 
    s.ID = m.ID;
    
-- FULL OUTER JOIN
-- List all matches and their squads, including matches without any squads and squads without any matches
SELECT 
    m.ID, 
    m.Date, 
    m.Stage, 
    m.Home_Team, 
    m.Away_Team, 
    s.Team, 
    s.Player, 
    s.Position, 
    s.Club
FROM 
    worldcup_matches AS m
LEFT JOIN 
    worldcup_squads AS s 
ON 
    m.ID = s.ID

UNION

SELECT 
    m.ID, 
    m.Date, 
    m.Stage, 
    m.Home_Team, 
    m.Away_Team, 
    s.Team, 
    s.Player, 
    s.Position, 
    s.Club
FROM 
    worldcup_squads AS s
RIGHT JOIN 
    worldcup_matches AS m 
ON 
    s.ID = m.ID;


    
                                                  -- subqueries--
 -- Find players who have scored more goals than the average number of goals scored by all players. 
 SELECT player
FROM worldcup_squads
WHERE goals > (SELECT AVG(goals) FROM worldcup_squads);



-- In which year did the World Cup have the most participating teams?
SELECT year, Host_country
FROM worldcups
WHERE Host_Country = (
  SELECT MAX(Host_Country)
  FROM worldcups
);

select * from worldcups;


-- Which country has finished as the runner-up the most times in World Cup history
SELECT host_country
FROM worldcups
WHERE Host_Country = (
  SELECT Host_Country
  FROM worldcups
  GROUP BY Host_Country
  ORDER BY SUM(runners_up) DESC
  LIMIT 1
);

-- Find the teams that participated in matches where the match date was after the 1st of December 2022.
SELECT DISTINCT Team
FROM worldcup_squads
WHERE ID IN (
    SELECT ID 
    FROM worldcup_matches
    WHERE Date > '2022-12-01'
);

--  List the clubs that have players who participated in matches hosted by Qatar
SELECT DISTINCT Club
FROM worldcup_squads
WHERE ID IN (
    SELECT ID 
    FROM worldcup_matches 
    WHERE "Host Team" = TRUE
);

-- Find all matches where a player aged 30 or above participated
SELECT *
FROM worldcup_matches
WHERE ID IN (
    SELECT ID 
    FROM worldcup_squads
    WHERE Age >= 30
);




 
                                                             -- VIEWS--
 -- CREATING VIEW TO JOIN WORLDCP_MATCHES WITH WORLD_CUPSQUADS

 CREATE VIEW match_squad_views1 AS
SELECT 
    ID, 
    Date, 
    Stage, 
    Home_Team,
    Away_Team, 
    Team, 
    Position, 
    Player, 
    Age, 
    League, 
    Club
FROM 
    worldcup_matches 
JOIN 
    worldcup_squads 
    USING(ID);
    
    -- TO VIEW THW CREATED VIEW
    SELECT * FROM MATCH_SQUAD_VIEWS1;

--  List all players from a specific match
SELECT Player, Position, Team
FROM match_squad_views1
WHERE ID = 1; 

-- Find matches where players from a specific club participated
SELECT DISTINCT Date, Home_Team, Away_Team
FROM match_squad_views1
WHERE Club = 'Bayer Leverkusen';

-- Count the number of players from each team in a specific match
SELECT Team, COUNT(Player) AS PlayerCount
FROM match_squad_views1
WHERE ID = 1
GROUP BY Team;



 

 
  



 
  



 
 
 








 