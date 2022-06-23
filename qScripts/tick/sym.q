quote:([]
 time:`timespan$();
 sym:`g#`symbol$();
 bid:`float$();
 ask:`float$();
 bsize:`long$();
 asize:`long$();
 mode:();
 ex:()
 );
 
trade:([]
 time:`timespan$();
 sym:`g#`symbol$(); 
 price:`float$();
 size:`int$();
 stop:`boolean$();
 cond:`char$();
 ex:`char$()
 );

aggTQ:([]
 time:`timespan$();
 sym:`g#`symbol$();		/Both Tables
 maxP:`float$();		/From Trade
 minP:`float$();		/From Trade
 Vol:`long$();			/From Trade
 maxBid:`float$();		/From Quote
 minAsk:`float$()		/From Quote
 );

 tt:([]
  time:`timespan$();
  sym:`$();
  timestamp:`timestamp$();
  title:();
  ups:`long$();
  downs:`long$();
  id:();
  url:();
  comms_num:`long$();
  body:()
  );
 
 cc:([]
  time:`timespan$();
  sym:`$();
  timestamp:`timestamp$();
  ups:`long$();
  downs:`long$();
  body:()
  );