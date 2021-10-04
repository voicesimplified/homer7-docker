function checkRAW()
	local protoType = GetHEPProtoType()
	-- Check if we have SIP type 
	if protoType ~= 1 then
		return
	end
	-- original SIP message Payload
	local raw = GetRawMessage()
--	Logp("ERROR", "raw", raw)
	-- Create lua table 
	local headers = {}

	local name, value = string.match(raw,"(X%-VS%-TrackingID):%s*(.-)\r\n")
	if name == "X-VS-TrackingID" then
--		Logp("ERROR", name, value)
		headers[name] = value
	end
	local name, value = string.match(raw,"(X%-VS%-OriginalDDI):%s+(.-)\r\n")
	if name == "X-VS-OriginalDDI" then
--		Logp("ERROR", name, value)
		headers[name] = value
	end
	local name, value = string.match(raw,"(X%-VS%-RTP%-Route):%s+(.-)\r\n")
	if name == "X-VS-RTP-Route" then
--		Logp("ERROR", name, value)
		headers[name] = value
	end
	local name, value = raw:match("(X%-VS%-AccountI[Dd]):%s+(.-)\r\n")
	if name == "X-VS-AccountID" or name == "X-VS-AccountId" then
--		Logp("ERROR", name, value)
		headers["X-VS-AccountID"] = value
	end
	local name, value = string.match(raw,"(X%-VS%-PresentedCLI):%s+(.-)\r\n")
	if name == "X-VS-PresentedCLI" then
--		Logp("ERROR", name, value)
		headers[name] = value
	end
	SetCustomSIPHeader(headers)
	Logp("ERROR", "Parsed Headers", headers)
	return 
end
