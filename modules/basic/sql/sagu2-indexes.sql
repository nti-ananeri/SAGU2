CREATE INDEX idx_finincomeforecast_isprocessed ON finIncomeForecast(isProcessed) WHERE isProcessed = FALSE;

CREATE INDEX idx_finincomeforecast_isprocessed_isaccounted ON finIncomeForecast(isProcessed, isAccounted) WHERE isProcessed = FALSE AND isAccounted = FALSE;
