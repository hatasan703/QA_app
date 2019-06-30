<template>
    <div class="howToItem">
        <section><h3 v-html="title"></h3></section>
        <img
            :alt="imageAlt"
            :src="imageSrc"
        />
    </div>
</template>

<script>
export default {
    props: {
        title: {
            type: String,
            required: true,
        },
        imageSrc: {
            type: String,
            required: true,
        },
        imageAlt: {
            type: String,
            required: true,
        },
    },
};
</script>
