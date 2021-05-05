-----------------------------------------------------------------------------------------------------------------------------------------
-- CRIADOR
-----------------------------------------------------------------------------------------------------------------------------------------
-- FEITO POR Devil#0069 / https://github.com/ydevilsz
-- Script GRATUITO!
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emp = {}

Tunnel.bindInterface('devil',emp)

quantidade = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function emp.devilquantidade()
    local source = source
    if quantidade[source] == nil then
        quantidade[source] = 1 -- DARÁ ISSO POR VEZ AO PLAYERS
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emp.devilcheckPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tubarao.permissao") then -- CASO QUEIRA COM PERMISSÃO E SÓ ATIVAR NO CLIENT-SIDE E CRIAR O GRUPO DA PERMISSÃO
		TriggerClientEvent("Notify",source,"sucesso","Você iniciou o emprego, vá até a marcação no mapa.")
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para acessar.")
		return false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emp.devilcheckPagamento()
	emp.devilquantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,"barbatana",quantidade[source]) -- ITEM DADO AO JOGADOR
		quantidade[source] = nil
		return true
	end
end