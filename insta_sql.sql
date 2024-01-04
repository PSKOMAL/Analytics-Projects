create database insta;
use insta;

-- KPI's 
	
    select * from insta_cat;
    select * from insta_chan;
    select * from insta_follow;
	
    ALTER TABLE insta_cat
	CHANGE COLUMN `Eng Rate` Eng_Rate text;
    
    ALTER TABLE insta_chan
    CHANGE COLUMN `rank` rankk text;
    
    ALTER TABLE insta_cat
	CHANGE COLUMN `Eng Rate` Eng_Rate text;
    
    set sql_safe_updates=0;
    UPDATE insta_follow
	SET Posts = 
	CASE 
    WHEN RIGHT(Posts, 1) = 'K' THEN CAST(SUBSTRING(Posts, 1, LENGTH(Posts) - 1) AS DECIMAL(10, 2)) * 100
    ELSE CAST(Posts AS DECIMAL(10, 2))
  END;


    

-- KPI 1 Count of Posts and Count of Followers by name

	SELECT name, Posts, Followers
	FROM insta_follow
	GROUP BY Followers,Posts, name
    limit 15;
    
-- KPI 2 Count of Followers by Category and channel_Info
  
	SELECT ic.Category, icn.channel_Info,
    SUM(CAST(insta_follow.Followers AS DECIMAL(18, 0))) AS TotalFollowers
	FROM insta_cat ic
	JOIN insta_chan icn ON ic.rank = icn.rankk
	JOIN insta_follow ON ic.rank = insta_follow.rank
	GROUP BY ic.Category, icn.channel_Info;
    
    
-- KPI 3 Top 5 Categories with the Highest Engagement Rate:

	SELECT Category, AVG(CAST(Eng_Rate AS DECIMAL(10,2))) AS Avg_Engagement_Rate
	FROM insta_cat
	WHERE Category IS NOT NULL AND Category != ''
	GROUP BY Category
	ORDER BY Avg_Engagement_Rate DESC
	LIMIT 5;

    
-- KPI 4 Influencers with the Highest Post Frequency:

	SELECT insta_follow.rank,
    insta_follow.name,
    CAST(insta_follow.Followers AS DECIMAL(18, 0)) AS Followers, insta_follow.Posts AS Posts,
    CAST(insta_follow.Posts AS FLOAT) / NULLIF(CAST(insta_follow.Followers AS DECIMAL(18, 0)), 0) AS Posts_Per_Follower
	FROM insta_follow
	ORDER BY Posts_Per_Follower DESC
	LIMIT 5;

	
-- KPI 5 

    SELECT ic.channel_Info, AVG(ic.Avg_Likes ) as AvgLikes
    FROM insta_chan ic
    WHERE ic.channel_Info IS NOT NULL AND ic.channel_Info != ''
	GROUP BY ic.channel_Info
	ORDER BY AvgLikes DESC
	LIMIT 5;


