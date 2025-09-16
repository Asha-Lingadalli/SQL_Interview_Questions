-- Drop old table if exists (optional)
DROP TABLE IF EXISTS icc_world_cup;

-- Create table with Draw column
CREATE TABLE icc_world_cup (
    Team_1 VARCHAR(50),
    Team_2 VARCHAR(50),
    Winner VARCHAR(50),
    Draw   VARCHAR(3)   -- values: 'Yes' or 'No'
);

-- Insert values (all are wins/losses, so Draw = 'No')
INSERT INTO icc_world_cup (Team_1, Team_2, Winner, Draw) VALUES
('India', 'SL', 'India', 'No'),
('SL', 'Aus', 'Aus', 'No'),
('SA', 'Eng', 'Eng', 'No'),
('Eng', 'Nz', 'Nz', 'No'),
('Aus', 'India', 'India', 'No');

-- Example row where the match was a draw
INSERT INTO icc_world_cup (Team_1, Team_2, Winner, Draw) VALUES
('India', 'Pak', NULL, 'Yes');


select * from icc_world_cup 

-- select team_name,count(1) as no_of_matches_played,sum(win_flag) as no_of_matches_won,
-- count(1) - sum(win_flag) as no_of_losses
-- from(
-- select team_1 as team_name ,
-- case when team_1 = Winner then 1 else 0 end as win_flag
-- from icc_world_cup 
-- Union all
-- select team_2 as team_name ,
-- case when team_2 = Winner then 1 else 0 end as win_flag
-- from icc_world_cup ) A
-- group by team_name
-- order by no_of_matches_won desc



WITH match_results AS (
    SELECT 
        team_1 AS team_name,
        CASE WHEN team_1 = winner THEN 1 ELSE 0 END AS win_flag,
        CASE WHEN UPPER(draw) = 'YES' THEN 1 ELSE 0 END AS draw_flag
    FROM icc_world_cup

    UNION ALL

    SELECT 
        team_2 AS team_name,
        CASE WHEN team_2 = winner THEN 1 ELSE 0 END AS win_flag,
        CASE WHEN UPPER(draw) = 'YES' THEN 1 ELSE 0 END AS draw_flag
    FROM icc_world_cup
),
team_stats AS (
    SELECT 
        team_name,
        COUNT(1) AS no_of_matches_played,
        SUM(win_flag) AS no_of_matches_won,
        SUM(draw_flag) AS no_of_draws,
        COUNT(1) - SUM(win_flag) - SUM(draw_flag) AS no_of_losses
    FROM match_results
    GROUP BY team_name
)
SELECT * 
FROM team_stats
ORDER BY no_of_matches_won DESC, no_of_draws DESC;


-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Q2)




