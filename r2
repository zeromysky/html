<?php
/**
 * redis
 */
//实例化redis
$redis = new Redis();
//连接
$redis->connect('127.0.0.1', 6379);
//检测是否连接成功
echo "Server is running: " . $redis->ping();
// 输出结果 Server is running: +PONG



　　// 设置一个字符串的值
$redis->set('cat', 111);

//获取一个字符串的值
echo $redis->get('cat'); // 111

// 重复set
$redis->set('cat', 222);
echo $redis->get('cat'); // 222

//列表
    //存储数据到列表中
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'css');
    $redis->lpush('list', 'php');

    //获取列表中所有的值
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>'; 

    //从右侧加入一个
    $redis->rpush('list', 'mysql');
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>';

    //从左侧弹出一个
    $redis->lpop('list');
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>';

    //从右侧弹出一个
    $redis->rpop('list');
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>';

    // 结果
    // Array ( [0] => php [1] => css [2] => html )
    // Array ( [0] => php [1] => css [2] => html [3] => mysql )
    // Array ( [0] => css [1] => html [2] => mysql )
    // Array ( [0] => css [1] => html )


//列表
    //存储数据到列表中
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'css');
    $redis->lpush('list', 'php');
    $redis->lpush('list', 'mysql');
    $redis->lpush('list', 'javascript');
    $redis->lpush('list', 'ajax');

    //获取列表中所有的值
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>'; 

    //获取列表的长度
    $length = $redis->lsize('list');
    echo $length;echo '<br>';

    //返回列表key中index位置的值
    echo $redis->lget('list', 2);echo '<br>';
    echo $redis->lindex('list', 2);echo '<br>';

    //设置列表中index位置的值
    echo $redis->lset('list', 2, 'linux');echo '<br>';
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>';

    //返回key中从start到end位置间的元素
    $list = $redis->lrange('list', 0, 2);
    print_r($list);echo '<br>';

    $list = $redis->lgetrange('list', 0, 2);
    print_r($list);echo '<br>';

    //截取链表中start到end的元素
　　　　//截取列表后列表发生变化,列表保留截取的元素,其余的删除
    $list = $redis->ltrim('list', 0, 1);
    print_r($list);echo '<br>';
    
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>';
    // 结果
    // Array ( [0] => ajax [1] => javascript [2] => mysql [3] => php [4] => css [5] => html )
    // 6
    // mysql
    // mysql
    // 1
    // Array ( [0] => ajax [1] => javascript [2] => linux [3] => php [4] => css [5] => html )
    // Array ( [0] => ajax [1] => javascript [2] => linux )
    // Array ( [0] => ajax [1] => javascript [2] => linux )
    // 1
    // Array ( [0] => ajax [1] => javascript )


//列表
    //存储数据到列表中
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'css');
    $redis->lpush('list', 'php');
    $redis->lpush('list', 'mysql');
    $redis->lpush('list', 'javascript');
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'html');
    $redis->lpush('list', 'ajax');

    //获取列表中所有的值
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>'; 

    //删除列表中count个值为value的元素
    //从左向右删
    $redis->lrem('list', 'html', 2);
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>'; 
    
    //从右向左删
    $redis->lrem('list', 'html', -2);
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>'; 

    //删除所有
    $redis->lrem('list', 'html', 0);
    $list = $redis->lrange('list', 0, -1);
    print_r($list);echo '<br>';

    // 结果
    // Array ( [0] => ajax [1] => html [2] => html [3] => html [4] => javascript [5] => mysql [6] => php [7] => css [8] => html [9] => html [10] => html )
    // Array ( [0] => ajax [1] => html [2] => javascript [3] => mysql [4] => php [5] => css [6] => html [7] => html [8] => html )
    // Array ( [0] => ajax [1] => html [2] => javascript [3] => mysql [4] => php [5] => css [6] => html )
    // Array ( [0] => ajax [1] => javascript [2] => mysql [3] => php [4] => css )



//字典
    //给hash表中某个key设置value
    //如果没有则设置成功,返回1,如果存在会替换原有的值,返回0,失败返回0
    echo $redis->hset('hash', 'cat', 'cat');echo '<br>';
    echo $redis->hset('hash', 'cat', 'cat');echo '<br>';
    echo $redis->hset('hash', 'cat', 'cat1');echo '<br>';
    echo $redis->hset('hash', 'dog', 'dog');echo '<br>';
    echo $redis->hset('hash', 'bird', 'bird');echo '<br>';
    echo $redis->hset('hash', 'monkey', 'monkey');echo '<br>';
    //获取hash中某个key的值
    echo $redis->hget('hash', 'cat');echo '<br>';

    //获取hash中所有的keys
    $arr = $redis->hkeys('hash');
    print_r($arr);echo '<br>';

    //获取hash中所有的值 顺序是随机的
    $arr = $redis->hvals('hash');
    print_r($arr);echo '<br>';

    //获取一个hash中所有的key和value 顺序是随机的
    $arr = $redis->hgetall('hash');
    print_r($arr);echo '<br>';

    //获取hash中key的数量
    echo $redis->hlen('hash');echo '<br>';

    //删除hash中一个key 如果表不存在或key不存在则返回false
    echo $redis->hdel('hash', 'dog');echo '<br>';
    var_dump($redis->hdel('hash', 'rabbit'));echo '<br>';

    // 结果
    // 1
    // 0
    // 0
    // 1
    // 1
    // 1
    // cat1
    // Array ( [0] => cat [1] => dog [2] => bird [3] => monkey )
    // Array ( [0] => cat1 [1] => dog [2] => bird [3] => monkey )
    // Array ( [cat] => cat1 [dog] => dog [bird] => bird [monkey] => monkey )
    // 4
    // 1
    // int(0)

//字典
    //批量设置多个key的值
    $arr = [1=>1, 2=>2, 3=>3, 4=>4, 5=>5];
    $redis->hmset('hash', $arr);
    print_r($redis->hgetall('hash'));echo '<br>';

    // 批量获得额多个key的值
    $arr = [1, 2, 3, 5];
    $hash = $redis->hmget('hash', $arr);
    print_r($hash);echo '<br>';

    //检测hash中某个key知否存在
    echo $redis->hexists('hash', '1');echo '<br>';
    var_dump($redis->hexists('hash', 'cat'));echo '<br>';

    print_r($redis->hgetall('hash'));echo '<br>';

    //给hash表中key增加一个整数值
    $redis->hincrby('hash', '1', 1);
    print_r($redis->hgetall('hash'));echo '<br>';

    //给hash中的某个key增加一个浮点值
    $redis->hincrbyfloat('hash', 2, 1.3);
    print_r($redis->hgetall('hash'));echo '<br>';

    //结果
    // Array ( [1] => 1 [2] => 2 [3] => 3 [4] => 4 [5] => 5 )
    // Array ( [1] => 1 [2] => 2 [3] => 3 [5] => 5 )
    // 1
    // bool(false)
    // Array ( [1] => 1 [2] => 2 [3] => 3 [4] => 4 [5] => 5 )
    // Array ( [1] => 2 [2] => 2 [3] => 3 [4] => 4 [5] => 5 )
    // Array ( [1] => 2 [2] => 3.3 [3] => 3 [4] => 4 [5] => 5 )



//集合
    // 添加一个元素
    echo $redis->sadd('set', 'cat');echo '<br>';
    echo $redis->sadd('set', 'cat');echo '<br>';
    echo $redis->sadd('set', 'dog');echo '<br>';
    echo $redis->sadd('set', 'rabbit');echo '<br>';
    echo $redis->sadd('set', 'bear');echo '<br>';
    echo $redis->sadd('set', 'horse');echo '<br>';

    // 查看集合中所有的元素
    $set = $redis->smembers('set');
    print_r($set);echo '<br>';

    //删除集合中的value
    echo $redis->srem('set', 'cat');echo '<br>';
    var_dump($redis->srem('set', 'bird'));echo '<br>';

    $set = $redis->smembers('set');
    print_r($set);echo '<br>';

    //判断元素是否是set的成员
    var_dump($redis->sismember('set', 'dog'));echo '<br>';
    var_dump($redis->sismember('set', 'bird'));echo '<br>';

    //查看集合中成员的数量
    echo $redis->scard('set');echo '<br>';

    //移除并返回集合中的一个随机元素(返回被移除的元素)
    echo $redis->spop('set');echo '<br>';

    print_r($redis->smembers('set'));echo '<br>';

    // 结果
    // 1
    // 0
    // 1
    // 1
    // 1
    // 1
    // Array ( [0] => rabbit [1] => cat [2] => bear [3] => dog [4] => horse )
    // 1
    // int(0)
    // Array ( [0] => dog [1] => rabbit [2] => horse [3] => bear )
    // bool(true)
    // bool(false)
    // 4
    // bear
    // Array ( [0] => dog [1] => rabbit [2] => horse )

//集合
    $redis->sadd('set', 'horse');
    $redis->sadd('set', 'cat');
    $redis->sadd('set', 'dog');
    $redis->sadd('set', 'bird');
    $redis->sadd('set2', 'fish');
    $redis->sadd('set2', 'dog');
    $redis->sadd('set2', 'bird');

    print_r($redis->smembers('set'));echo '<br>';
    print_r($redis->smembers('set2'));echo '<br>';

    //返回集合的交集
    print_r($redis->sinter('set', 'set2'));echo '<br>';

    //执行交集操作 并结果放到一个集合中
    $redis->sinterstore('output', 'set', 'set2');
    print_r($redis->smembers('output'));echo '<br>';

    //返回集合的并集
    print_r($redis->sunion('set', 'set2'));echo '<br>';

    //执行并集操作 并结果放到一个集合中
    $redis->sunionstore('output', 'set', 'set2');
    print_r($redis->smembers('output'));echo '<br>';

    //返回集合的差集
    print_r($redis->sdiff('set', 'set2'));echo '<br>';

    //执行差集操作 并结果放到一个集合中
    $redis->sdiffstore('output', 'set', 'set2');
    print_r($redis->smembers('output'));echo '<br>';

    // 结果
    // Array ( [0] => cat [1] => dog [2] => bird [3] => horse )
    // Array ( [0] => bird [1] => dog [2] => fish )
    // Array ( [0] => bird [1] => dog )
    // Array ( [0] => dog [1] => bird )
    // Array ( [0] => cat [1] => dog [2] => bird [3] => horse [4] => fish )
    // Array ( [0] => cat [1] => dog [2] => bird [3] => horse [4] => fish )
    // Array ( [0] => horse [1] => cat )
    // Array ( [0] => horse [1] => cat )


//有序集合
    //添加元素
    echo $redis->zadd('set', 1, 'cat');echo '<br>';
    echo $redis->zadd('set', 2, 'dog');echo '<br>';
    echo $redis->zadd('set', 3, 'fish');echo '<br>';
    echo $redis->zadd('set', 4, 'dog');echo '<br>';
    echo $redis->zadd('set', 4, 'bird');echo '<br>';
    
    //返回集合中的所有元素
    print_r($redis->zrange('set', 0, -1));echo '<br>';
    print_r($redis->zrange('set', 0, -1, true));echo '<br>';

    //返回元素的score值
    echo $redis->zscore('set', 'dog');echo '<br>';

    //返回存储的个数
    echo $redis->zcard('set');echo '<br>';

    //删除指定成员
    $redis->zrem('set', 'cat');
    print_r($redis->zrange('set', 0, -1));echo '<br>';

    //返回集合中介于min和max之间的值的个数
    print_r($redis->zcount('set', 3, 5));echo '<br>';

    //返回有序集合中score介于min和max之间的值
    print_r($redis->zrangebyscore('set', 3, 5));echo '<br>';
    print_r($redis->zrangebyscore('set', 3, 5, ['withscores'=>true]));echo '<br>';

    //返回集合中指定区间内所有的值
    print_r($redis->zrevrange('set', 1, 2));echo '<br>';
    print_r($redis->zrevrange('set', 1, 2, true));echo '<br>';


    //有序集合中指定值的socre增加
    echo $redis->zscore('set', 'dog');echo '<br>';
    $redis->zincrby('set', 2, 'dog');
    echo $redis->zscore('set', 'dog');echo '<br>';

    //移除score值介于min和max之间的元素
    print_r($redis->zrange('set', 0, -1, true));echo '<br>';
    print_r($redis->zremrangebyscore('set', 3, 4));echo '<br>';
    print_r($redis->zrange('set', 0, -1, true));echo '<br>';

    //结果
    // 1
    // 0
    // 0
    // 0
    // 0
    // Array ( [0] => cat [1] => fish [2] => bird [3] => dog )
    // Array ( [cat] => 1 [fish] => 3 [bird] => 4 [dog] => 4 )
    // 4
    // 4
    // Array ( [0] => fish [1] => bird [2] => dog )
    // 3
    // Array ( [0] => fish [1] => bird [2] => dog )
    // Array ( [fish] => 3 [bird] => 4 [dog] => 4 )
    // Array ( [0] => bird [1] => fish )
    // Array ( [bird] => 4 [fish] => 3 )
    // 4
    // 6
    // Array ( [fish] => 3 [bird] => 4 [dog] => 6 )
    // 2
    // Array ( [dog] => 6 )
