-- 1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет

SELECT COUNT(*) AS total_likes_under_12
FROM likes l
INNER JOIN users u ON l.user_id = u.id
INNER JOIN profiles p ON u.id = p.user_id
WHERE DATE_ADD(p.birthday, INTERVAL 12 YEAR) > CURDATE()

-- 2. Определить кто больше поставил лайков (всего): мужчины или женщины

SELECT 
    profiles.gender, 
    COUNT(likes.id) AS total_likes 
FROM 
    likes 
    JOIN profiles ON likes.user_id = profiles.user_id 
GROUP BY 
    profiles.gender 
ORDER BY 
    total_likes DESC;

-- 3. Вывести всех пользователей, которые не отправляли сообщения

SELECT id, username
FROM users
WHERE id NOT IN (
  SELECT DISTINCT sender_id
  FROM messages
)
-- 4. Пусть задан некоторый пользователь (для примера взят с ID = 1). Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений

SELECT
    f.id AS friend_id,
    COUNT(m.id) AS message_count
FROM
    friends f
    JOIN messages m ON m.sender_id = f.id AND m.receiver_id = 1
WHERE
    f.user_id = 1
GROUP BY
    f.id
ORDER BY
    message_count DESC
LIMIT
    1;