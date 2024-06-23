<template>
  <h1>Counter</h1>
  <button @click="increment()">Increment</button>
  <button @click="decrement()">Decrement</button>
  <h2>{{ number }}</h2>
</template>


<script setup>
import { ref, onMounted } from 'vue';
import axios from "axios";


const number = ref(0);

const getNumber = async () => {

  try {
    const response = await axios.get("http://localhost:3000/number");
    number.value = response.data.number;
  } catch (error) {
    console.error(error);
  }

  return number;
};

const increment =  async () => {
  try{
    await axios.post("http://localhost:3000/increment");
    getNumber();
  }catch(error){
    console.error(error);
  }
}

const decrement =  async () => {
  try{
    await axios.post("http://localhost:3000/decrement");
    getNumber();
  }catch(error){
    console.error(error);
  }
} 

onMounted(() => {
  getNumber();
});

</script>

<style scoped>
</style>
