
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

(Select id Commercgroup_id,name Commercgroupname,parent_id Commercgroup_parent_id from CommercGroup where id in (
select row_value from "MSoft"."GetAllParentIDs2"('315'))) CG
join Commerc C on C.commercgroup_id=CG.Commercgroup_id 
join Goods G on G.commerc_id=C.id
join Firm F on G.firm_id=F.id
join Goods_Group GG on G.group_id=GG.id
join Country Con on Con.id=G.country_id
left join Trade T on T.id=G.trade_id
left join Gentrade GT on T.gentrade_id=GT.id
left join Inter I on GT.inter_id=I.id
left join Bar B on B.NewGoods_ID=G.id and B.isActive=1
left join (select GOODS_ID,mnn,description from (
SELECT b.GOODS_ID,A.mnn,A.description 
 ,row_number() over (partition by B.goods_Id order by a.id desc) nn
 FROM "MSoft"."RefDrug_Andora" a
 JOIN "MSoft"."RefGoods_Andora" b ON A.DrugID=b.GUID
where isnull(A.description,'')<>''
) S
where nn=1) D on D.goods_id=G.id;
OUTPUT TO "C:\goods.csv" 
FORMAT ASCII DELIMITED BY '\x09' QUOTE '';
