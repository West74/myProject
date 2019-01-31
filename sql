
'insert into Invoice_Spec_Bar(ID, Part_ID, BARCode, Thermal) on existing update values ('+



select CG.*,C.id commerc_id,C.name commercname,
  G.id goods_id,G.name goodsname,G.unit,
  G.firm_id,F.name,
  G.group_id goodsgroup_id,GG.name goodsgroupname,
  G.country_id,Con.name countryname,
  G.trade_id,T.name tradename,
  I.id mnn_id,I.name mnnnmae
  ,GetGoodsFormByGoods(G.id) goodsform
  ,D.description,B.Barcode
 from

