const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const session = require('express-session');

var pool = mysql.createPool({
    host: '127.0.0.1',
    user: 'root',
    password: "",
    port: 3306,
    database: 'uc',
    connectionLimit: 15
});

var server = express();
server.use(cors({
    origin: ['http://127.0.0.1:8080', "http://localhost:8080"],
    credentials: true  //每次请求时需要验证
}));
// 配置session模块
server.use(session({
    secret: '128位字符串',//安全字符串
    resave: true,//请求时更新数据
    saveUninitialized: true//保存初始数据
}))
// 配置项目静态目录
server.use(express.static("public"));
server.listen(4000);

// 获取用户信息
server.get('/api/getInfo', (req, res) => {
    var str = req.query;
    console.log(str);
    var sql = 'SELECT * FROM uc_user WHERE token = ?';
    pool.query(sql, [str.token], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            // res.send({code:200,msg:'注册成功'});
            const msg = {
                code: 10000,
                msg: 'sucess',
                data: result[0]
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
        } else {
            res.send({ code: 404, msg: '获取用户信息失败' });
        }
    })
});
// 验证用户登录
server.get('/api/login', (req, res) => {
    var str = req.query;
    console.log(str);
    var sql = 'SELECT * FROM uc_user WHERE uname=? AND upwd=?';
    pool.query(sql, [str.uname, str.upwd], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                data: {
                    account: result[0]
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
                code: 10000,
                msg: 'success'
            };
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
        } else {
            res.send({ code: 404, msg: '登录失败' })
        }
    });
});

//查询商品
server.get('/api/goods', (req, res) => {
    var sql = 'SELECT * FROM uc_goods';
    pool.query(sql, (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                total: 2,
                totalNum: 2,
                data: result
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '查询失败' })
        }
    });
});
//根据goodsSPU查询商品
server.get('/api/goodsDetails', (req, res) => {
    const goodsSPU = req.query.goodsSPU;
    console.log(req);
    const sql = 'SELECT * FROM uc_goods WHERE goodsSPU=?';
    pool.query(sql, [goodsSPU], (err, result) => {
        if (err) throw err;
        console.log(result)
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: result
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '查询失败' })
        }
    })
})
// 添加商品
server.get('/api/goods/add', (req, res) => {
    const data = req.query;
    const sql = `INSERT INTO uc_goods SET ?`;
    pool.query(sql, [data], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: null
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '添加商品失败', data: null })
        }
    })
})
// 编辑商品
server.get('api/goods/update', (req, res) => {
    const data = req.query;
    const goodsSPU = res.query.goodsSPU;
    const sql = `UPDATE uc_goods SET ? WHERE goodsSPU=?`;
    pool.query(sql, [data], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: null
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '编辑会员失败', data: null })
        }
    })
})
//查询会员列表
server.get('/api/member', (req, res) => {
    var sql = 'SELECT * FROM uc_member';
    pool.query(sql, (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: result,
                totalNum: result.length
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '查询会员列表失败', data: null })
        }
    });
});
// 添加会员
server.get('/api/member/add', (req, res) => {
    const data = req.query;
    const sql = 'INSERT INTO uc_member SET ?';
    pool.query(sql, [data], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: null
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '添加会员失败', data: null })
        }
    })
})
// 编辑会员
server.get('api/member/update', (req, res) => {
    const data = req.query;
    const delverID = res.query.delverID;
    const sql = `UPDATE uc_member SET ? WHERE delverID=?`;
    pool.query(sql, [data], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: null
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '编辑会员失败', data: null })
        }
    })
})
// 根据代理人查询订单
server.get('api/memberOrder', (req, res) => {
    const delverID = req.query.delverID;
    const sql = 'SELECT * FROM uc_order FROM delverID=?';
    pool.query(sql, [delverID], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: result
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '查询会员订单失败', data: null })
        }
    })
})
// 查询订单列表
server.get('/api/orders', (req, res) => {
    const sql = "SELECT * FROM uc_orders";
    let good = [];
    let member = [];
    let msg = {
        code: '',
        msg: '',
        data: []
    };
    pool.query(sql, (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            msg.data = result;
            result.forEach(item => {
                good.push(item.goodsCode);
                member.push(item.memberID);
            })
            async function goods(good) {
                let data = msg.data
                let sql1 = "SELECT * FROM uc_goods WHERE goodsSPU=?";
                let allGoods = good.map(item => {
                    return new Promise((resolve, reject) => {
                        pool.query(sql1, [item], (err, result) => {
                            if (err) throw err;
                            if (result.length > 0) {
                                data.forEach(item => {
                                    item.goosdsMessage = result[0];
                                })
                                resolve();
                            } else {
                                res.send({ code: 10000, msg: '获取商品信息失败' })
                            }
                        })
                    })
                })
                console.log(allGoods, 'all')
                await Promise.all(allGoods);
                return data;
            }
            goods(good).then(response => {
                console.log(response, 'res')
                const data = {
                    code: 10000,
                    msg: 'success',
                    data: response,
                    totalNum: msg.data.length
                }
                // console.log(data,'eeee')
                res.writeHead(200, { "Access-Control-Allow-Origin": "http://localhost:8080" });
                res.write(JSON.stringify(data));
                res.end()
            })
        } else {
            res.send({ code: 404, msg: 'error', data: null })
        }
    })
})
// 根据订单号查询订单
server.get('api/order/orderNo', (req, res) => {
    const orderNo = req.query.orderNo;
    const sql = 'SELECT * FROM uc_order FROM orderNo=?';
    pool.query(sql, [orderNo], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: result
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '查询会员订单失败', data: null })
        }
    })
})
// 根据收件人查询订单
server.get('api/order/receiver', (req, res) => {
    const receiver = req.query.receiver;
    const sql = 'SELECT * FROM uc_order FROM receiver=?';
    pool.query(sql, [receiver], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: result
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '查询会员订单失败', data: null })
        }
    })
})
// 编辑订单
server.get('/api/orders/update', (req, res) => {
    const data = req.query;
    const orderNo = req.query.orderNo;
    const sql = `UPDATE uc_orders SET ? WHERE orderNo = ?`;
    pool.query(sql, [data, orderNo], (err, result) => {
        if (err) throw err
        if (result.affectedRows > 0) {
            const msg = {
                code: 10000,
                msg: 'success',
                data: null
            }
            res.writeHead(200, {
                "Access-Control-Allow-Origin": "http://localhost:8080"
            })
            res.write(JSON.stringify(msg));
            res.end();
            // res.send({code:200,msg:'查询成功',data:result})
        } else {
            res.send({ code: 404, msg: '编辑订单失败', data: null })
        }
    })
})




