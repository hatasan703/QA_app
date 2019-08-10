<template>
    <div v-if="!isEmptyNoticeList" class="notice">
        <p class="notice__title">お知らせ</p>
        <button class="notice__button" @click="changeIsShown">
            開く
        </button>
        <div
            v-if="isShown"
            class="notice__list">
            <div
                v-for="(notice, index) in noticeList"
                :key="index"
                class="notice-item"
            >
                <p class="notice-item__label">お知らせ</p>
                <div class="notice-item__title">
                    <a :href="makeNoticeUrl(notice.id)">
                        {{ notice.title }}
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        noticeList: {
            type: Array,
            default: () => ([])
        },
        noticeLink: {
            type: String,
            required: true
        }
    },
    data() {
        return {
            isShown: false,
        };
    },
    computed: {
        isEmptyNoticeList() {
            return this.noticeList.length === 0;
        },
    },
    methods: {
        makeNoticeUrl(id) {
            return `${this.noticeLink}/${id}`;
        },
        changeIsShown() {
            this.isShown = !this.isShown;
        }
    }
}
</script>

<style lang="scss" scoped>
.notice {
    padding: 10px 100px;
    text-align: center;

    &__title {
        font-size: 3em;
        font-weight: bold;
        color: #555;
    }
}

.notice-item {
    display: flex;
    margin-top: 10px;

    &__label {
        width: 70px;
        color: #FFF;
        background-color: #60cef0;
        text-align: center;
        font-size: 2em;
        font-weight: bold;
        padding: 5px 0;
    }

    &__title {
        margin-left: 20px;
        font-size: 2.5em;
        color: #555;
        text-decoration: none;
        padding: 5px 0;
    }
}

@media screen and (max-width: 640px) {
    .notice {
        padding: 10px 50px;

    }
}

</style>
