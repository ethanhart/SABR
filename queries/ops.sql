# Gets ops for  all players in Batting table for 2013
# Minimum of 299 ABs

SELECT playerID, yearID, teamID,
    (AB + BB + HBP + SF + SH) AS  PA,
    (H + BB + HBP) / (AB + BB + HBP + SF) AS OBP,
    (H + 2B + 2 * 3B + 3 * HR) / AB AS SLG,
    (H + BB + HBP)/ (AB + BB + HBP + SF) +
        (H + 2B + 2 * 3B + 3 * HR) / AB AS OPS
FROM Batting
WHERE yearID = 2013
HAVING PA > 299
ORDER BY OPS DESC
