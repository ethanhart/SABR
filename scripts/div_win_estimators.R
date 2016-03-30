win_estimators <- read.csv("win_estimators.csv")
AL_East_estimator <- subset(win_estimators, teamID == "NYA" | teamID == "BOS" | 
                              teamID == "BAL" | teamID == "TBA" | teamID == "TOR")
NL_West_estimator <- subset(win_estimators, teamID == "COL" | teamID == "SFN" | 
                              teamID == "ARI" | teamID == "LAN" | teamID == "SDN")

ALE_avgRuns <- mean(AL_East_estimator$R)
NLW_avgRuns <- mean(NL_West_estimator$R)
ALE_avgRunsA <- mean(AL_East_estimator$RA)
NLW_avgRunsA <- mean(NL_West_estimator$RA)

ALE_wp <- mean(AL_East_estimator$WPct)
NLW_wp <- mean(NL_West_estimator$WPct)

ALE_runPred <- ALE_avgRuns - sqrt(ALE_avgRunsA^2 / (1/(ALE_wp - 1/162) - 1))
NLW_runPred <- NLW_avgRuns - sqrt(NLW_avgRunsA^2 / (1/(NLW_wp - 1/162) - 1))