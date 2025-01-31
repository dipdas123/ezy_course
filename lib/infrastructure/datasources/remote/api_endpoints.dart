const BASE_URL = "https://ezyappteam.ezycourse.com/api/app";

const loginUrl = "$BASE_URL/student/auth/login";
const getFeeds = "$BASE_URL/teacher/community/getFeed";
const getCommentsOfAFeed = "$BASE_URL/student/comment/getComment/";
const getCommentsReplyOfAFeed = "$BASE_URL/student/comment/getReply/";
const createFeed = "$BASE_URL/teacher/community/createFeedWithUpload";
const getReactionsList = "$BASE_URL/teacher/community/getAllReactionType";
const updateOrCreateReaction = "$BASE_URL/teacher/community/createLike";