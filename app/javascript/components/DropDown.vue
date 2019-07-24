<template>
    <div class="dropdown">
        <input id="tg" class="dropInput" type="checkbox">
        <label for="tg" class="dropLabel">
            <span class="userName">{{ nickName }}</span>さん
        </label>
        <ul
            class="menu animation"
            @click="onClick"
        >
            <li class="item">
                <div class="img_human"></div>
                <a :href="`/users/${userId}`">マイページ</a>
            </li>
            <li class="item">
                <div class="img_config"></div>
                <a :href="`/identification/${userId}`">アカウント設定</a>
            </li>
            <li class="item">
                <div class="img_out"></div>
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
    },
    data() {
        return {
            isShownMenu: false,
        }
    },
    methods: {
        onClick() {
            this.isShownMenu = !this.isShownMenu;
        },
    },
};
</script>
