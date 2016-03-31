 # Get complete game stats
 # Include IP, SO9 (k/9), others

 SELECT playerID, yearID, teamID,
     ERA, CG, SO, SHO, IPOuts, W, L, GS,
     CG / GS AS CGperGS,
     IPOuts/3 AS IP,
     SO / (IPOuts/3/9) AS SO9,
     (IPOuts/3) / GS AS IPperGS,
     ((13*HR)+(3*(BB+HBP))-(2*SO))/(IPOuts/3) + 3.10 AS FIP
 FROM Pitching
 WHERE yearID > 1980
 HAVING GS > 10
 ORDER BY FIP ASC
