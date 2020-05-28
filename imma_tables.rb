require './imma'

def c0
  IMMA.new(
           yr: [4,:numeric,range: 1600..2024],
           mo: [2,:numeric,range: 1..12],
           dy: [2,:numeric,range: 1..31],
           hr: [4,:numeric,range: 0..23.99, scale: 0.01, unit: 'hour'],
          lat: [5,:numeric,range: -90.00..90.00, scale: 0.01, unit: 'degN'],
          lon: [6,:numeric,range: -179.99..359.99, scale: 0.01, unit: 'degE'],
           im: [2,:numeric,range: 0..99],
         attc: [1,:numeric,range: 0..9],
           ti: [1,:numeric,range: 0..3],
           li: [1,:numeric,range: 0..6],
           ds: [1,:numeric,range: 0..9],
           vs: [1,:numeric,range: 0..9],
          nid: [2,:numeric,range: 0..99],
           ii: [2,:numeric,range: 0..10],
           id: [9,:string],
           c1: [2,:string],
           di: [1,:numeric,range: 0..6],
            d: [3,:numeric,range: 1..362, unit: 'degree'],
           wi: [1,:numeric,range: 0..8],
            w: [3,:numeric,range: 0..99.9, scale:0.1, unit: 'm/s'],
           vi: [1,:numeric,range: 0..2],
           vv: [2,:numeric,range: 90..99],
           ww: [2,:numeric,range: 0..99],
           w1: [1,:numeric,range: 0..9],
          slp: [5,:numeric,range: 870.0..1074.6, scale:0.1,unit: 'hPa'],
            a: [1,:numeric,range: 0..8],
          ppp: [3,:numeric,range: 0..51.0, scale:0.1, unit: 'hPa'],
           it: [1,:numeric,range: 0..9],
           at: [4,:numeric,range: 99.9..99.9, scale:0.1, unit: 'degC'],
         wbti: [1,:numeric,range: 0..3],
          wbt: [4,:numeric,range: 99.9..99.9, scale:0.1, unit: 'degC'],
         dpti: [1,:numeric,range: 0..3],
          dpt: [4,:numeric,range: 99.9..99.9, scale:0.1, unit: 'degC'],
           si: [2,:numeric,range: 0..12],
          sst: [4,:numeric,range: -99.9..99.9, scale:0.1, unit: 'degC'],
            n: [1,:numeric,range: 0..9],
           nh: [1,:numeric,range: 0..9],
           cl: [1,:numeric,range: 0..9],
           hi: [1,:numeric,range: 0..1],
            h: [1,:numeric,range: 0..9],
           cm: [1,:numeric,range: 0..9],
           ch: [1,:numeric,range: 0..9],
           wd: [2,:numeric,range: 0..38],
           wp: [2,:numeric,range: 0..30],
           wh: [2,:numeric,range: 0..99],
           sd: [2,:numeric,range: 0..38],
           sp: [2,:numeric,range: 0..30],
           sh: [2,:numeric,range: 0..99]
  )
end

def c1
  IMMA.new(
         atti: [2, :numeric],
         attl: [2, :numeric]
  )
end
