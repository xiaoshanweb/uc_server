const express=require('express');
const mysql=require('mysql');
const cors=require('cors');
const session=require('express-session');

var pool=mysql.createPool({
    host:'127.0.0.1',
    user:'root',
    password:"",
    port:3306,
    database:'uc',
    connectionLimit:15
});

var server=express();
server.use(cors({
    origin:['http://127.0.0.1:8080',"http://localhost:8080"],
    credentials:true  //每次请求时需要验证
}));
// 配置session模块
server.use(session({
    secret:'128位字符串',//安全字符串
    resave:true,//请求时更新数据
    saveUninitialized:true//保存初始数据
}))
// 配置项目静态目录
server.use(express.static("public"));
server.listen(4000);

// 获取用户信息
server.get('/api/getInfo',(req,res)=>{
    var str=req.query;
    console.log(str);
    var sql='SELECT * FROM uc_user WHERE token = ?';
    pool.query(sql,[str.token],(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            // res.send({code:200,msg:'注册成功'});
            const msg = {
                code:10000,
                msg:'sucess',
                data:result[0]
            }
            res.writeHead(200,{
                "Access-Control-Allow-Origin":"http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
        }else{
            res.send({code:404,msg:'获取用户信息失败'});
        }
    })
});
// 验证用户登录
server.get('/api/login',(req,res)=>{
    var str=req.query;
    console.log(str);
    var sql='SELECT * FROM uc_user WHERE uname=? AND upwd=?';
    pool.query(sql,[str.uname,str.upwd],(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            const  msg = {
                data:{
                    account:result[0]
                },
                privilegeResources: [
                    {
                      code: 'anim reprehenderit',
                      appId: 'fugiat reprehenderit',
                      parentCode: 'cupidatat veniam dolor incididunt',
                      resourceGroupCode: 'enim esse occaecat dolore',
                      uri: 'voluptate velit adipisicing in',
                      name: 'magna',
                      status: -91038943.58647597,
                      type: -88876394.50587259
                    },
                    {
                      code: 'in ut',
                      appId: 'velit',
                      parentCode: 'deserunt magna sed non',
                      resourceGroupCode: 'ea anim aute',
                      uri: 'velit mollit proident',
                      name: 'fugiat dolore ea',
                      status: 59860391.494900346,
                      type: -55488321.74369948
                    }
                ],
                code:10000,
                msg:'success'
            };
            res.writeHead(200,{
                "Access-Control-Allow-Origin":"http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
        }else{
            res.send({code:404,msg:'登录失败'})
        }
    });
});

//查询商品
server.get('/api/goods',(req,res)=>{
    var sql='SELECT * FROM uc_goods';
    pool.query(sql,(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            const msg = {
                code:10000,
                msg:'success',
                total:2,
                totalNum:2,
                data:result
            }
            res.writeHead(200,{
                "Access-Control-Allow-Origin":"http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        }else{
            res.send({code:404,msg:'查询失败'})
        }
    });
});
//根据goodsSPU查询商品
server.get('/api/goodsDetails',(req,res)=>{
    const goodsSPU = req.query.goodsSPU;
    console.log(req);
    const sql = 'SELECT * FROM uc_goods WHERE goodsSPU=?';
    pool.query(sql,[goodsSPU],(err,result)=>{
        if(err) throw err;
        console.log(result)
        if(result.length>0){
            const msg = {
                code:10000,
                msg:'success',
                data:result
            }
            res.writeHead(200,{
                "Access-Control-Allow-Origin":"http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        }else{
            res.send({code:404,msg:'查询失败'})
        }
    })
})
//查询会员列表
server.get('/api/member',(req,res)=>{
    var sql='SELECT * FROM uc_member';
    pool.query(sql,(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            const msg = {
                code:10000,
                msg:'success',
                data:result,
                totalNum:result.length
            }
            res.writeHead(200,{
                "Access-Control-Allow-Origin":"http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        }else{
            res.send({code:404,msg:'查询会员列表失败',data:null})
        }
    });
});

// 查询订单列表
server.get('/api/orders',(req,res)=>{
    const sql = "SELECT * FROM uc_orders";
    let good = [];
    let member = [];
    let msg = {
        code:'',
        msg:'',
        data:[]
    };
    pool.query(sql,(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            msg.data = result;
            result.forEach(item=>{
                good.push(item.goodsCode);
                member.push(item.memberID);
            })
            async function goods(good){
                let data = msg.data
                let sql1 = "SELECT * FROM uc_goods WHERE goodsSPU=?";
                let allGoods = good.map(item=>{
                    return new Promise((resolve,reject)=>{
                        pool.query(sql1,[item],(err,result)=>{
                            if(err) throw err;
                            if(result.length>0){
                                data.forEach(item=>{
                                    item.goosdsMessage = result[0];
                                })
                                resolve();
                                // console.log(msg.data,'goods-2')
                            }else{
                                res.send({code:10000,msg:'获取商品信息失败'})
                            }
                        }) 
                   }) 
                })
                console.log(allGoods,'all')
                await Promise.all(allGoods);
                return data;
            }
            goods(good).then(response=>{
                console.log(response,'res')
                const data = {
                    code:10000,
                    msg:'success',
                    data:response,
                    totalNum:msg.data.length
                }
                // console.log(data,'eeee')
                res.writeHead(200,{"Access-Control-Allow-Origin":"http://localhost:8080"});
                res.write(JSON.stringify(data));
                res.end()
            })  
        }else{
            res.send({code:404,msg:'error',data:null})
        }
    })
})
server.get('/details',(req,res)=>{
    var pid=req.query.pid;
    var output={
        product:{},
        pics:[]
    }
    var sql='SELECT * FROM product WHERE pid=?';
    pool.query(sql,[pid],(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            output.product=result[0];
            var sql2='SELECT * FROM product_pic WHERE product_id=?';
            pool.query(sql2,[pid],(err,result)=>{
                if(err) throw err;
                console.log(result);
                if(result.length>0){
                    output.pics=result;
                    // res.send(output);
                    res.writeHead(200,{
                        "Access-Control-Allow-Origin":"http://localhost:8080"
                    })
                    res.write(JSON.stringify(output));
                    res.end();
                }else{
                    res.send({code:404,msg:'查询图片失败'})
                }
            })
        }else{
            res.send({code:404,msg:'查询商品失败'})
        }
    });
});
// 添加购物车
server.get('/addCart',(req,res)=>{
    var uid=req.session.uid;
    if(!uid){
        res.send({code:404,msg:"请登录"})
        return;
    }
    var pid=req.query.pid;
    var title=req.query.title;
    var pic=req.query.pic;
    var price=req.query.price;
   var sql='SELECT * FROM shopping_cart WHERE pid=?';
   pool.query(sql,[pid],(err,result)=>{
       if(err) throw err;
       if(result.length==0){
            var sql2 =  `INSERT INTO shopping_cart VALUES(null,${pid},'${title}',${price},'${pic}',1)`;
            pool.query(sql2,(err,result)=>{
                if(err) throw err;
                if(result.affectedRows>0){
                    // res.send({code:200,msg:'添加成功'})
                    var msg='添加成功';
                    res.writeHead(200,{
                        "Access-Control-Allow-Origin":"http://localhost:8080"
                    })
                    res.write(msg);
                    res.end();
                }else{
                    res.send({code:404,msg:'插入失败'})
                }
            })
       }else{
            var count=result[0].count;
            var sql2 = `UPDATE shopping_cart SET count=${count}+1 WHERE pid=?`;
            pool.query(sql2,[pid],(err,result)=>{
                if(err) throw err;
                console.log(result);
                if(result.affectedRows>0){
                    // res.send({code:200,msg:'数据修改成功'})
                    var msg='修改数据成功';
                    res.writeHead(200,{
                        "Access-Control-Allow-Origin":"http://localhost:8080"
                    })
                    res.write(msg);
                    res.end();
                }else{
                    res.send({code:404,msg:'数据修改失败'})
                }
            })
       }
   })
})
//http://127.0.0.1:4000/addcart?pid=1&title=串饰&price=999&pic=12344.jpg

//查看购物车
server.get('/searchCart',(req,res)=>{
    var uid=req.session.uid;
    if(!uid){
        res.send({code:404,msg:'请登录'});
        return;
    }
    var sql =  'SELECT * FROM shopping_cart';
    pool.query(sql,(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            console.log(result)
            // res.send({code:200,msg:'success',data:result});
            res.writeHead(200,{
                "Access-Control-Allow-Origin":"http://localhost:8080"
            })
            res.write(JSON.stringify(result));
            res.end();
        }else{
            res.send({code:404,msg:'failed'});
        }
    })
})