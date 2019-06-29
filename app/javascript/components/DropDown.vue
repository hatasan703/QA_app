<template>
    <div class="dropdown">
        <input id="tg" class="dropInput" type="checkbox">
        <label for="tg" class="dropLabel">
            <span class="userName">{{ nickName }}</span>さん
        </label>
        <ul class="menu animation">
            <li class="item">
                <a :href="`/users/${userId}`">マイページ</a>
            </li>
            <li class="item">
                <a :href="`/identification/${userId}`">アカウント設定</a>
            </li>
            <li class="item">
                <a data-method="delete" href="/users/sign_out">ログアウト</a>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    props: {
        nickName: {
            type: String,
            required: true,
        },
        userId: {
            type: Number,
            required: true,
        },
        logoutLink: {
            type: String,
            required: true,
        }
    },
    mounted() {
        console.log(this.logoutLink);
    }
};
</script>
